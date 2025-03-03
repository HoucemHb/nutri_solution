import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProfilePageComponent } from './profile-page/profile-page.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { HealthInfosComponent } from './health-infos/health-infos.component';


@NgModule({
  declarations: [ProfilePageComponent, HealthInfosComponent],
  imports: [CommonModule, SharedModule, FormsModule],
  exports: [ProfilePageComponent, HealthInfosComponent],
})
export class ProfileModule {}
