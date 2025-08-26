import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from 'typeorm';
import { UserEntity } from '../user/user.entity';
import { Message } from './message.entity';

@Entity('conversations')
@Index(['participant1', 'participant2'])
export class Conversation {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => UserEntity, { eager: true })
  participant1: UserEntity;

  @ManyToOne(() => UserEntity, { eager: true })
  participant2: UserEntity;

  @OneToMany(() => Message, (message) => message.conversation, {
    cascade: true,
  })
  messages: Message[];

  @Column({ type: 'text', nullable: true })
  lastMessage: string;

  @Column({ type: 'datetime', nullable: true })
  lastMessageTime: Date;

  @Column({ default: 0 })
  unreadCountParticipant1: number;

  @Column({ default: 0 })
  unreadCountParticipant2: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
