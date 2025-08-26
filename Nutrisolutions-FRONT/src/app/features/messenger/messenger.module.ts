import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SharedModule } from 'src/app/shared/shared.module';
import { MessengerComponent } from './messenger/messenger.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [MessengerComponent],
  imports: [
    CommonModule,
    FormsModule, // ✅ needed for ngModel
    SharedModule,
  ],
  exports: [MessengerComponent],
})
export class MessengerModule {}
