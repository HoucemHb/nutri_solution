import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  CreateDateColumn,
  Index,
} from 'typeorm';
import { Conversation } from './conversation.entity';
import { UserEntity } from 'src/user/user.entity';

export enum MessageType {
  TEXT = 'text',
  IMAGE = 'image',
  FILE = 'file',
}

@Entity('messages')
@Index(['conversation', 'createdAt'])
export class Message {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => Conversation, (conversation) => conversation.messages)
  conversation: Conversation;

  @ManyToOne(() => UserEntity, { eager: true })
  sender: UserEntity;

  @Column({ type: 'text' })
  content: string;

  @Column({
    type: 'enum',
    enum: MessageType,
    default: MessageType.TEXT,
  })
  type: MessageType;

  @Column({ default: false })
  isRead: boolean;

  @Column({ type: 'datetime', nullable: true })
  readAt: Date;

  @Column({ type: 'json', nullable: true })
  metadata: any; // For file info, image dimensions, etc.

  @CreateDateColumn()
  createdAt: Date;
}
