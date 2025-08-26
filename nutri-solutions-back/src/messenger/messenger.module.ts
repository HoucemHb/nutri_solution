import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MessagesService } from './messenger.service';
import { Message } from './message.entity';
import { Conversation } from './conversation.entity';
import { UserEntity } from 'src/user/user.entity';
import { MessagesGateway } from './messenger.gateway';
import { MessagesController } from './messenger.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Message, Conversation, UserEntity])],
  providers: [MessagesService, MessagesGateway],
  controllers: [MessagesController],
  exports: [MessagesService], // <- important to allow other modules to inject it
})
export class MessagesModule {}
