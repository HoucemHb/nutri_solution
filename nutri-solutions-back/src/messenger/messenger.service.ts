// messages.service.ts
import {
  Injectable,
  NotFoundException,
  ForbiddenException,
  Logger,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Message, MessageType } from './message.entity';
import { Conversation } from './conversation.entity';
import { UserEntity } from '../user/user.entity';

@Injectable()
export class MessagesService {
  private readonly logger = new Logger(MessagesService.name);

  constructor(
    @InjectRepository(Message)
    private messageRepository: Repository<Message>,
    @InjectRepository(Conversation)
    private conversationRepository: Repository<Conversation>,
    @InjectRepository(UserEntity)
    private userRepository: Repository<UserEntity>,
  ) {}

  async getOrCreateConversation(
    participant1Id: string,
    participant2Id: string,
  ): Promise<Conversation> {
    // Check if conversation already exists
    let conversation = await this.conversationRepository
      .createQueryBuilder('conv')
      .where(
        '(conv.participant1 = :p1 AND conv.participant2 = :p2) OR (conv.participant1 = :p2 AND conv.participant2 = :p1)',
        { p1: participant1Id, p2: participant2Id },
      )
      .getOne();

    if (!conversation) {
      const participant1 = await this.userRepository.findOne({
        where: { id: participant1Id },
      });
      const participant2 = await this.userRepository.findOne({
        where: { id: participant2Id },
      });

      if (!participant1 || !participant2) {
        throw new NotFoundException('User not found');
      }

      conversation = this.conversationRepository.create({
        participant1,
        participant2,
      });

      conversation = await this.conversationRepository.save(conversation);
    }

    return conversation;
  }

  async getUserConversations(userId: string): Promise<Conversation[]> {
    this.logger.log(`Fetching conversations for user: ${userId}`);

    return this.conversationRepository
      .createQueryBuilder('conv')
      .leftJoinAndSelect('conv.participant1', 'p1')
      .leftJoinAndSelect('conv.participant2', 'p2')
      .where('conv.participant1 = :userId OR conv.participant2 = :userId', {
        userId,
      })
      .orderBy('conv.lastMessageTime', 'DESC')
      .getMany();
  }

  async sendMessage(
    senderId: string,
    conversationId: string,
    content: string,
    type: MessageType = MessageType.TEXT,
    metadata?: any,
  ): Promise<Message> {
    const conversation = await this.conversationRepository.findOne({
      where: { id: conversationId },
      relations: ['participant1', 'participant2'],
    });

    if (!conversation) {
      throw new NotFoundException('Conversation not found');
    }

    // Check if sender is part of the conversation
    if (
      conversation.participant1.id !== senderId &&
      conversation.participant2.id !== senderId
    ) {
      throw new ForbiddenException('You are not part of this conversation');
    }

    const sender = await this.userRepository.findOne({
      where: { id: senderId },
    });
    if (!sender) {
      throw new NotFoundException('Sender not found');
    }

    const message = this.messageRepository.create({
      conversation,
      sender,
      content,
      type,
      metadata,
    });

    const savedMessage = await this.messageRepository.save(message);

    // Update conversation last message info
    conversation.lastMessage = content;
    conversation.lastMessageTime = new Date();

    // Increment unread count for the other participant
    if (conversation.participant1.id === senderId) {
      conversation.unreadCountParticipant2++;
    } else {
      conversation.unreadCountParticipant1++;
    }

    await this.conversationRepository.save(conversation);

    return savedMessage;
  }

  async getConversationMessages(
    conversationId: string,
    userId: string,
    page: number = 1,
    limit: number = 50,
  ): Promise<{ messages: Message[]; total: number }> {
    const conversation = await this.conversationRepository.findOne({
      where: { id: conversationId },
      relations: ['participant1', 'participant2'],
    });

    if (!conversation) {
      throw new NotFoundException('Conversation not found');
    }

    // Check if user is part of the conversation
    if (
      conversation.participant1.id !== userId &&
      conversation.participant2.id !== userId
    ) {
      throw new ForbiddenException('You are not part of this conversation');
    }

    const [messages, total] = await this.messageRepository.findAndCount({
      where: { conversation: { id: conversationId } },
      order: { createdAt: 'DESC' },
      skip: (page - 1) * limit,
      take: limit,
      relations: ['sender'],
    });

    return { messages: messages.reverse(), total };
  }

  async markMessagesAsRead(
    conversationId: string,
    userId: string,
  ): Promise<void> {
    const conversation = await this.conversationRepository.findOne({
      where: { id: conversationId },
      relations: ['participant1', 'participant2'],
    });

    if (!conversation) {
      throw new NotFoundException('Conversation not found');
    }

    // Mark unread messages as read
    await this.messageRepository
      .createQueryBuilder()
      .update(Message)
      .set({ isRead: true, readAt: new Date() })
      .where('conversationId = :conversationId', { conversationId })
      .andWhere('senderId != :userId', { userId })
      .andWhere('isRead = false')
      .execute();

    // Reset unread count
    if (conversation.participant1.id === userId) {
      conversation.unreadCountParticipant1 = 0;
    } else {
      conversation.unreadCountParticipant2 = 0;
    }

    await this.conversationRepository.save(conversation);
  }
}
