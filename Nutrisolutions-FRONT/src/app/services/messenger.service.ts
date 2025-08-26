// services/messages.service.ts
import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import {
  Conversation,
  Message,
  SendMessageRequest,
  CreateConversationRequest,
  TypingEvent,
  UserStatusEvent,
  MessageType,
} from '../models/message.model';
import { APP_API, APP_CONST } from '../core/constants/constants.config';
import { AuthService } from './auth.service';
import { Socket, io } from 'socket.io-client';

@Injectable({
  providedIn: 'root',
})
export class MessagesService {
  private http = inject(HttpClient);
  private authService = inject(AuthService);
  private apiUrl = APP_API.base_url + '/messages';
  private socket: Socket | null = null;

  // Reactive state management
  private conversationsSubject = new BehaviorSubject<Conversation[]>([]);
  private activeConversationSubject = new BehaviorSubject<Conversation | null>(
    null
  );
  private messagesSubject = new BehaviorSubject<Message[]>([]);
  private typingUsersSubject = new BehaviorSubject<Set<string>>(new Set());
  private onlineUsersSubject = new BehaviorSubject<Set<string>>(new Set());

  // Public observables
  conversations$ = this.conversationsSubject.asObservable();
  activeConversation$ = this.activeConversationSubject.asObservable();
  messages$ = this.messagesSubject.asObservable();
  typingUsers$ = this.typingUsersSubject.asObservable();
  onlineUsers$ = this.onlineUsersSubject.asObservable();

  constructor() {
    this.initializeSocket();
  }

  private initializeSocket(): void {
    const token = localStorage.getItem(APP_CONST.tokenLocalStorage);
    if (!token) return;

    this.socket = io(`${APP_API.base_url}/messages`, {
      auth: { token },
      transports: ['websocket'],
      autoConnect: true,
      reconnection: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 1000,
    });

    this.socket.on('connect', () => {
      console.log('Connected to messaging server');
      const activeConv = this.activeConversationSubject.value;
      if (activeConv) {
        this.joinConversation(activeConv.id);
      }
    });

    this.socket.on('newMessage', (message: Message) => {
      console.log('Received new message:', message);
      this.handleNewMessage(message);
    });

    this.socket.on(
      'userTyping',
      (data: { userId: string; isTyping: boolean; conversationId: string }) => {
        console.log('User typing event:', data);
        this.handleTypingEvent(data);
      }
    );

    this.socket.on('onlineUsers', (onlineUsers: Array<string>) => {
      console.log('Online Users:', onlineUsers);
      this.onlineUsersSubject.next(new Set(onlineUsers));
    });

    this.socket.on('userOnline', (data: UserStatusEvent) => {
      console.log('User online:', data);
      const onlineUsers = new Set(this.onlineUsersSubject.value);
      onlineUsers.add(data.userId);
      this.onlineUsersSubject.next(onlineUsers);
    });

    this.socket.on('userOffline', (data: UserStatusEvent) => {
      console.log('User offline:', data);
      const onlineUsers = new Set(this.onlineUsersSubject.value);
      onlineUsers.delete(data.userId);
      this.onlineUsersSubject.next(onlineUsers);
    });

    this.socket.on(
      'messagesRead',
      (data: { conversationId: string; userId: string }) => {
        console.log('Messages read:', data);
        this.handleMessagesRead(data);
      }
    );

    this.socket.on('disconnect', (reason) => {
      console.log('Disconnected from messaging server:', reason);
    });

    this.socket.on('connect_error', (error) => {
      console.error('Socket connection error:', error);
    });
  }

  // REST API Methods
  getUserConversations(): Observable<Conversation[]> {
    return this.http.get<Conversation[]>(`${this.apiUrl}/conversations`);
  }

  getOrCreateConversation(participantId: string): Observable<Conversation> {
    const request: CreateConversationRequest = { participantId };
    return this.http.post<Conversation>(
      `${this.apiUrl}/conversations`,
      request
    );
  }

  getConversationMessages(
    conversationId: string,
    page: number = 1,
    limit: number = 50
  ): Observable<{ messages: Message[]; total: number }> {
    return this.http.get<{ messages: Message[]; total: number }>(
      `${this.apiUrl}/conversations/${conversationId}/messages?page=${page}&limit=${limit}`
    );
  }

  sendMessage(
    conversationId: string,
    content: string,
    type: MessageType = MessageType.TEXT,
    metadata?: any
  ): Observable<boolean> {
    return new Observable<boolean>((observer) => {
      if (this.socket?.connected) {
        // emit the message over socket
        this.socket.emit(
          'sendMessage',
          { conversationId, content, type, metadata },
          (response: { error?: string }) => {
            if (response?.error) {
              // error returned from server
              observer.error(response.error);
            } else {
              // server acknowledged with saved message
              observer.next(true);
              observer.complete();
            }
          }
        );
      }
    });
  }

  sendMessageToSocket(
    conversationId: string,
    content: string,
    type?: MessageType | undefined,
    metadata?: any
  ): void {
    const request: SendMessageRequest = { content, type, metadata };

    if (this.socket?.connected) {
      this.socket.emit('sendMessage', { conversationId, ...request });
    }
  }

  markConversationAsRead(
    conversationId: string
  ): Observable<{ success: boolean }> {
    return this.http.post<{ success: boolean }>(
      `${this.apiUrl}/conversations/${conversationId}/read`,
      {}
    );
  }

  // Socket Methods
  joinConversation(conversationId: string): void {
    if (this.socket?.connected) {
      console.log('Joining conversation:', conversationId);
      this.socket.emit('joinConversation', { conversationId });
    }
  }

  leaveConversation(conversationId: string): void {
    if (this.socket?.connected) {
      console.log('Leaving conversation:', conversationId);
      this.socket.emit('leaveConversation', { conversationId });
    }
  }

  sendTypingIndicator(conversationId: string, isTyping: boolean): void {
    if (this.socket?.connected) {
      this.socket.emit('typing', { conversationId, isTyping });
    }
  }

  // State Management Methods
  loadConversations(): void {
    this.getUserConversations().subscribe({
      next: (conversations) => {
        console.log('Loaded conversations:', conversations);
        this.conversationsSubject.next(conversations);
      },
      error: (error) => {
        console.error('Error loading conversations:', error);
      },
    });
  }

  setActiveConversation(conversation: Conversation): void {
    console.log('Setting active conversation:', conversation);
    if (this.activeConversationSubject.value?.id != conversation.id) {
      this.leaveConversation(conversation.id);
      this.activeConversationSubject.next(conversation);
      this.loadConversationMessages(conversation.id);
      this.joinConversation(conversation.id);

      this.markConversationAsRead(conversation.id).subscribe({
        next: () => {
          this.resetUnreadCount(conversation.id);
        },
        error: (error) => {
          console.error('Error marking conversation as read:', error);
        },
      });
    }
  }

  loadConversationMessages(conversationId: string): void {
    this.getConversationMessages(conversationId).subscribe({
      next: (data) => {
        console.log('Loaded messages for conversation:', conversationId, data);
        this.messagesSubject.next(data.messages);
      },
      error: (error) => {
        console.error('Error loading messages:', error);
      },
    });
  }

  // Method to add message immediately for sender
  addMessageToCurrentConversation(message: Message): void {
    const activeConv = this.activeConversationSubject.value;
    if (activeConv && message.conversation.id === activeConv.id) {
      const currentMessages = [...this.messagesSubject.value];

      // Check for duplicates
      if (!currentMessages.find((m) => m.id === message.id)) {
        currentMessages.push(message);
        this.messagesSubject.next(currentMessages);
        console.log(
          'Added message to current conversation immediately:',
          message
        );
      }
    }

    // Update conversation list
    this.updateConversationWithNewMessage(message);
  }

  // Helper methods
  private handleNewMessage(message: Message): void {
    console.log('Handling new message:', message);
    const currentMessages = [...this.messagesSubject.value];
    const activeConv = this.activeConversationSubject.value;

    // Add message to current messages if it belongs to active conversation
    if (activeConv && message.conversation.id === activeConv.id) {
      // Avoid duplicates
      currentMessages.push(message);
      this.messagesSubject.next(currentMessages);
      const updatedConv = {
        ...activeConv,
        lastMessage: message.content,
        lastMessageTime: message.createdAt,
      };
      this.activeConversationSubject.next(updatedConv);
      console.log('Added message to current list via socket:', message);
    }

    // Always update conversations list with new message info
    this.updateConversationWithNewMessage(message);
  }

  private updateConversationWithNewMessage(message: Message): void {
    const conversations = [...this.conversationsSubject.value];
    const currentUserId = this.authService.getUserId();
    const activeConv = this.activeConversationSubject.value;

    console.log(
      'Updating conversation with new message:',
      message.id,
      'Active conv:',
      activeConv?.id
    );

    const updatedConversations = conversations.map((conv) => {
      if (conv.id === message.conversation.id) {
        const updatedConv = {
          ...conv,
          lastMessage: message.content,
          lastMessageTime: message.createdAt,
        };

        // Update unread count only if message is not from current user
        // and conversation is not currently active
        if (
          message.sender.id !== currentUserId &&
          (!activeConv || activeConv.id !== conv.id)
        ) {
          console.log('Incrementing unread count for conversation:', conv.id);
          if (conv.participant1.id === currentUserId) {
            updatedConv.unreadCountParticipant1 =
              conv.unreadCountParticipant1 + 1;
          } else if (conv.participant2.id === currentUserId) {
            updatedConv.unreadCountParticipant2 =
              conv.unreadCountParticipant2 + 1;
          }
        }

        return updatedConv;
      }
      return conv;
    });

    this.conversationsSubject.next(updatedConversations);
    console.log('Updated conversations list');
  }

  private handleTypingEvent(data: {
    userId: string;
    isTyping: boolean;
    conversationId?: string;
  }): void {
    const typingUsers = new Set(this.typingUsersSubject.value);
    const activeConv = this.activeConversationSubject.value;

    // Only show typing indicator if it's for the active conversation
    if (
      !activeConv ||
      (data.conversationId && data.conversationId !== activeConv.id)
    ) {
      return;
    }

    if (data.isTyping) {
      typingUsers.add(data.userId);
    } else {
      typingUsers.delete(data.userId);
    }
    this.typingUsersSubject.next(typingUsers);
  }

  private handleMessagesRead(data: {
    conversationId: string;
    userId: string;
  }): void {
    const activeConv = this.activeConversationSubject.value;

    // Update message read status in current messages if it's the active conversation
    if (activeConv && activeConv.id === data.conversationId) {
      const messages = [...this.messagesSubject.value];
      const currentUserId = this.authService.getUserId();

      const updatedMessages = messages.map((msg) => {
        if (msg.sender.id === currentUserId) {
          return { ...msg, isRead: true, readAt: new Date() };
        }
        return msg;
      });

      this.messagesSubject.next(updatedMessages);
    }
  }

  private resetUnreadCount(conversationId: string): void {
    const conversations = [...this.conversationsSubject.value];
    const currentUserId = this.authService.getUserId();

    const updatedConversations = conversations.map((conv) => {
      if (conv.id === conversationId) {
        const updatedConv = { ...conv };
        if (conv.participant1.id === currentUserId) {
          updatedConv.unreadCountParticipant1 = 0;
        } else if (conv.participant2.id === currentUserId) {
          updatedConv.unreadCountParticipant2 = 0;
        }
        return updatedConv;
      }
      return conv;
    });

    this.conversationsSubject.next(updatedConversations);
  }

  // Utility methods
  getTotalUnreadCount(): number {
    const conversations = this.conversationsSubject.value;
    const currentUserId = this.authService.getUserId();
    return conversations.reduce((total, conv) => {
      if (conv.participant1.id === currentUserId) {
        return total + conv.unreadCountParticipant1;
      } else if (conv.participant2.id === currentUserId) {
        return total + conv.unreadCountParticipant2;
      }
      return total;
    }, 0);
  }

  getOtherParticipant(conversation: Conversation): any {
    const currentUserId = this.authService.getUserId();
    return conversation.participant1.id === currentUserId
      ? conversation.participant2
      : conversation.participant1;
  }

  isSocketConnected(): boolean {
    return this.socket?.connected || false;
  }

  reconnectSocket(): void {
    if (this.socket) {
      this.socket.disconnect();
    }
    this.initializeSocket();
  }

  disconnect(): void {
    if (this.socket) {
      this.socket.disconnect();
      this.socket = null;
    }
  }
}
