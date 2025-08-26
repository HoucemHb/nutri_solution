export enum MessageType {
  TEXT = 'text',
  IMAGE = 'image',
  FILE = 'file',
}

export interface Message {
  id: string;
  content: string;
  type: MessageType;
  isRead: boolean;
  conversation: Conversation;
  readAt?: Date;
  metadata?: any;
  createdAt: Date;
  sender: {
    id: string;
    name: string;
    email: string;
    role: string;
  };
}

export interface Conversation {
  id: string;
  participant1: {
    id: string;
    name: string;
    email: string;
    role: string;
    profilePictureUrl: string;
  };
  participant2: {
    id: string;
    name: string;
    email: string;
    role: string;
    profilePictureUrl: string;
  };
  messages?: Message[];
  lastMessage?: string;
  lastMessageTime?: Date;
  unreadCountParticipant1: number;
  unreadCountParticipant2: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface SendMessageRequest {
  content: string;
  type?: MessageType;
  metadata?: any;
}

export interface CreateConversationRequest {
  participantId: string;
}

export interface TypingEvent {
  userId: string;
  isTyping: boolean;
}

export interface UserStatusEvent {
  userId: string;
}
