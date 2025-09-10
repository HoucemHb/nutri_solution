// components/messenger/messenger.component.ts

import {
  Component,
  OnInit,
  OnDestroy,
  AfterViewChecked,
  ViewChild,
  ElementRef,
  ChangeDetectorRef,
  NgZone,
  inject,
} from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Observable, Subscription } from 'rxjs';
import {
  Conversation,
  Message,
  MessageType,
} from 'src/app/models/message.model';
import { AuthService } from 'src/app/services/auth.service';
import { MessagesService } from 'src/app/services/messenger.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-messenger',
  templateUrl: './messenger.component.html',
  styleUrls: ['./messenger.component.css'],
})
export class MessengerComponent implements OnInit, OnDestroy, AfterViewChecked {
  base_url = environment.apiUrl;

  @ViewChild('messagesContainer') messagesContainer!: ElementRef;
  @ViewChild('messageInput') messageInput!: ElementRef;

  conversations: Conversation[] = [];
  filteredConversations: Conversation[] = [];
  activeConversation: Conversation | null = null;
  messages: Message[] = [];
  typingUsers = new Set<string>();
  onlineUsers = new Set<string>();
  searchQuery = '';
  messageText = '';
  isSending = false;
  messages$!: Observable<Message[]>;
  toastr = inject(ToastrService);

  private subscriptions: Subscription[] = [];
  private typingTimeout: any;
  private shouldScrollToBottom = false;

  constructor(
    private messagesService: MessagesService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {
    this.messages$ = this.messagesService.messages$; // subscribe to updates
  }

  ngOnInit(): void {
    this.initializeSubscriptions();
    this.loadConversations();
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach((sub) => sub.unsubscribe());
    this.messagesService.disconnect();
    if (this.typingTimeout) {
      clearTimeout(this.typingTimeout);
    }
  }

  ngAfterViewChecked(): void {
    if (this.shouldScrollToBottom) {
      this.scrollToBottom();
      this.shouldScrollToBottom = false;
    }
  }

  private initializeSubscriptions(): void {
    // Subscribe to conversations with zone handling for better change detection
    this.subscriptions.push(
      this.messagesService.conversations$.subscribe((conversations) => {
        this.ngZone.run(() => {
          this.conversations = [...conversations]; // Create new reference
          this.filterConversations();
          this.cdr.markForCheck(); // Trigger change detection
        });
      })
    );

    // Subscribe to active conversation
    this.subscriptions.push(
      this.messagesService.activeConversation$.subscribe((conversation) => {
        this.ngZone.run(() => {
          this.activeConversation = conversation;
          this.cdr.markForCheck();
        });
      })
    );

    // Subscribe to messages with zone handling
    this.subscriptions.push(
      this.messagesService.messages$.subscribe((messages) => {
        this.ngZone.run(() => {
          this.messages = [...messages]; // Create new reference
          this.shouldScrollToBottom = true;
          this.cdr.markForCheck();
        });
      })
    );

    // Subscribe to typing users
    this.subscriptions.push(
      this.messagesService.typingUsers$.subscribe((typingUsers) => {
        this.ngZone.run(() => {
          this.typingUsers = new Set(typingUsers);
          this.cdr.markForCheck();
        });
      })
    );

    // Subscribe to online users
    this.subscriptions.push(
      this.messagesService.onlineUsers$.subscribe((onlineUsers) => {
        this.ngZone.run(() => {
          this.onlineUsers = new Set(onlineUsers);
          console.log('Online Users: ' + onlineUsers);

          this.cdr.markForCheck();
        });
      })
    );
  }

  loadConversations(): void {
    this.messagesService.loadConversations();
  }

  filterConversations(): void {
    if (!this.searchQuery.trim()) {
      this.filteredConversations = [...this.conversations];
    } else {
      const query = this.searchQuery.toLowerCase();
      this.filteredConversations = this.conversations.filter((conv) => {
        const otherParticipant = this.getOtherParticipant(conv);
        return (
          otherParticipant.name.toLowerCase().includes(query) ||
          (conv.lastMessage && conv.lastMessage.toLowerCase().includes(query))
        );
      });
    }
  }

  selectConversation(conversation: Conversation): void {
    if (this.activeConversation?.id !== conversation.id) {
      // Leave previous conversation
      if (this.activeConversation) {
        this.messagesService.leaveConversation(this.activeConversation.id);
      }

      // Set new active conversation
      this.messagesService.setActiveConversation(conversation);
      this.shouldScrollToBottom = true;
    }
  }

  sendMessage(): void {
    if (
      !this.messageText.trim() ||
      !this.activeConversation ||
      this.isSending
    ) {
      return;
    }

    this.isSending = true;
    const content = this.messageText.trim();
    const conversationId = this.activeConversation.id;

    // Clear message input immediately for better UX
    this.messageText = '';

    this.messagesService
      .sendMessage(conversationId, content, MessageType.TEXT)
      .subscribe({
        next: (isSent) => {
          console.log('isSent : ' + isSent);

          this.isSending = !isSent;
        },
        error: (error) => {
          console.error('Error sending message:', error);
          this.toastr.error(error);

          this.isSending = false;
          // Restore message text on error
          this.messageText = content;
        },
      });
  }

  handleTyping(): void {
    if (!this.activeConversation) return;

    // Send typing indicator
    this.messagesService.sendTypingIndicator(this.activeConversation.id, true);

    // Clear previous timeout
    if (this.typingTimeout) {
      clearTimeout(this.typingTimeout);
    }

    // Stop typing after 2 seconds of inactivity
    this.typingTimeout = setTimeout(() => {
      if (this.activeConversation) {
        this.messagesService.sendTypingIndicator(
          this.activeConversation.id,
          false
        );
      }
    }, 2000);

    // Auto-resize textarea
    this.autoResizeTextarea();
  }

  handleEnterKey(event: KeyboardEvent): void {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      this.sendMessage();
    }
  }

  private autoResizeTextarea(): void {
    if (this.messageInput && this.messageInput.nativeElement) {
      const textarea = this.messageInput.nativeElement;
      textarea.style.height = 'auto';
      textarea.style.height = Math.min(textarea.scrollHeight, 120) + 'px';
    }
  }

  private scrollToBottom(): void {
    if (this.messagesContainer && this.messagesContainer.nativeElement) {
      const container = this.messagesContainer.nativeElement;
      setTimeout(() => {
        container.scrollTop = container.scrollHeight;
      }, 0);
    }
  }

  // Helper methods
  getOtherParticipant(conversation: Conversation): any {
    return this.messagesService.getOtherParticipant(conversation);
  }

  getCurrentUserId(): string {
    return this.authService.getUserId();
  }

  getTotalUnreadCount(): number {
    return this.messagesService.getTotalUnreadCount();
  }

  getUnreadCount(conversation: Conversation): number {
    const currentUserId = this.getCurrentUserId();
    if (conversation.participant1.id === currentUserId) {
      return conversation.unreadCountParticipant1;
    } else if (conversation.participant2.id === currentUserId) {
      return conversation.unreadCountParticipant2;
    }
    return 0;
  }

  isUserOnline(userId: string): boolean {
    return this.onlineUsers.has(userId);
  }

  isUserTyping(userId: string): boolean {
    return this.typingUsers.has(userId);
  }

  formatTime(date: Date | string): string {
    if (!date) return '';

    const messageDate = new Date(date);
    const now = new Date();
    const diffMs = now.getTime() - messageDate.getTime();
    const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
    const diffDays = Math.floor(diffHours / 24);

    if (diffDays === 0) {
      if (diffHours === 0) {
        const diffMinutes = Math.floor(diffMs / (1000 * 60));
        return diffMinutes < 1 ? 'now' : `${diffMinutes}m`;
      }
      return `${diffHours}h`;
    } else if (diffDays === 1) {
      return 'yesterday';
    } else if (diffDays < 7) {
      return `${diffDays}d`;
    } else {
      return messageDate.toLocaleDateString();
    }
  }

  formatMessageTime(date: Date | string): string {
    if (!date) return '';

    const messageDate = new Date(date);
    return messageDate.toLocaleTimeString([], {
      hour: '2-digit',
      minute: '2-digit',
    });
  }

  // Track functions for ngFor
  trackConversation(index: number, conversation: Conversation): string {
    return conversation.id;
  }

  trackMessage(index: number, message: Message): string {
    return message.id;
  }

  // Debug methods
  checkSocketStatus(): boolean {
    return this.messagesService.isSocketConnected();
  }

  reconnectSocket(): void {
    this.messagesService.reconnectSocket();
  }
}
