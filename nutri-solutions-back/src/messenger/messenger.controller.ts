import { AuthGuard } from 'src/auth/guards/auth.guard';
import { MessageType } from './message.entity';
import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { MessagesService } from './messenger.service';

@Controller('messages')
@UseGuards(AuthGuard)
export class MessagesController {
  constructor(private messagesService: MessagesService) {}

  @Get('conversations')
  async getUserConversations(@Request() req) {
    return this.messagesService.getUserConversations(req.user.sub);
  }

  @Post('conversations')
  async getOrCreateConversation(
    @Body() body: { participantId: string },
    @Request() req,
  ) {
    return this.messagesService.getOrCreateConversation(
      req.user.sub,
      body.participantId,
    );
  }

  @Get('conversations/:conversationId/messages')
  async getConversationMessages(
    @Param('conversationId') conversationId: string,
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 50,
    @Request() req,
  ) {
    return this.messagesService.getConversationMessages(
      conversationId,
      req.user.sub,
      page,
      limit,
    );
  }

  // @Post('conversations/:conversationId/messages')
  // async sendMessage(
  //   @Param('conversationId') conversationId: string,
  //   @Body() body: { content: string; type?: MessageType; metadata?: any },
  //   @Request() req,
  // ) {
  //   return this.messagesService.sendMessage(
  //     req.user.sub,
  //     conversationId,
  //     body.content,
  //     body.type,
  //     body.metadata,
  //   );
  // }

  @Post('conversations/:conversationId/read')
  async markAsRead(
    @Param('conversationId') conversationId: string,
    @Request() req,
  ) {
    await this.messagesService.markMessagesAsRead(conversationId, req.user.sub);
    return { success: true };
  }
}
