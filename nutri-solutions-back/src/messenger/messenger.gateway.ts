// messages.gateway.ts
import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  WebSocketServer,
  ConnectedSocket,
  OnGatewayInit,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger, UseGuards } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { MessageType } from './message.entity';
import { MessagesService } from './messenger.service';

interface AuthenticatedSocket extends Socket {
  userId?: string;
  userRole?: string;
}

@WebSocketGateway({
  cors: {
    origin: '*', // Configure this properly for production
  },
  namespace: '/messages',
})
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  private connectedUsers = new Map<string, string>(); // userId -> socketId
  private readonly logger = new Logger(MessagesGateway.name);

  constructor(
    private messagesService: MessagesService,
    private jwtService: JwtService,
  ) {}

  afterInit(server: Server) {
    this.logger.log('WebSocket Gateway initialized');
  }

  async handleConnection(client: AuthenticatedSocket) {
    try {
      const token =
        client.handshake.auth.token ||
        client.handshake.headers.authorization?.replace('Bearer ', '');

      if (!token) {
        this.logger.warn('Client attempted to connect without token');
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token);
      client.userId = payload.sub || payload.id;
      client.userRole = payload.role;

      // Store connected user
      this.connectedUsers.set(client.userId, client.id);

      //notify him with already connected users
      client.emit('onlineUsers', Array.from(this.connectedUsers.keys()));

      // Join user to their personal room
      client.join(`user_${client.userId}`);

      // Notify others that user is online
      client.broadcast.emit('userOnline', { userId: client.userId });

      this.logger.log(`User ${client.userId} connected`);
    } catch (error) {
      this.logger.error('Authentication failed', error.message);
      client.disconnect();
    }
  }

  handleDisconnect(client: AuthenticatedSocket) {
    if (client.userId) {
      this.connectedUsers.delete(client.userId);
      client.broadcast.emit('userOffline', { userId: client.userId });
      this.logger.log(`User ${client.userId} disconnected`);
    }
  }

  @SubscribeMessage('joinConversation')
  async handleJoinConversation(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() data: { conversationId: string },
  ) {
    client.join(`conversation_${data.conversationId}`);

    // Mark messages as read when joining conversation
    await this.messagesService.markMessagesAsRead(
      data.conversationId,
      client.userId,
    );

    // Notify the conversation that messages were read
    client.to(`conversation_${data.conversationId}`).emit('messagesRead', {
      conversationId: data.conversationId,
      userId: client.userId,
    });
  }

  @SubscribeMessage('leaveConversation')
  handleLeaveConversation(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() data: { conversationId: string },
  ) {
    client.leave(`conversation_${data.conversationId}`);
  }

  @SubscribeMessage('sendMessage')
  async handleSendMessage(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody()
    data: {
      conversationId: string;
      content: string;
      type?: MessageType;
      metadata?: any;
    },
    @ConnectedSocket() socket: any,
  ) {
    try {
      const message = await this.messagesService.sendMessage(
        client.userId,
        data.conversationId,
        data.content,
        data.type,
        data.metadata,
      );

      // Broadcast to room
      this.server
        .to(`conversation_${data.conversationId}`)
        .emit('newMessage', message);

      // ✅ Call ack so client receives response
      return { message };
    } catch (error) {
      return { error: error.message };
    }
  }

  @SubscribeMessage('typing')
  handleTyping(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() data: { conversationId: string; isTyping: boolean },
  ) {
    client.to(`conversation_${data.conversationId}`).emit('userTyping', {
      userId: client.userId,
      isTyping: data.isTyping,
    });
  }

  // Method to check if user is online
  isUserOnline(userId: string): boolean {
    return this.connectedUsers.has(userId);
  }

  // Method to get online users (you can call this from other services)
  getOnlineUsers(): string[] {
    return Array.from(this.connectedUsers.keys());
  }
}
