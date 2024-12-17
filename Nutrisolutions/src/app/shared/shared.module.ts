import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthBackgroundComponent } from './components/auth-background/auth-background.component';
import { InputFieldComponent } from './components/input-field/input-field.component';
import { ProgressIndicatorComponent } from './components/progress-indicator/progress-indicator.component';
import { ButtonComponent } from './components/button/button.component';
import { AuthDropdownComponent } from './components/auth-dropdown/auth-dropdown.component';
import { AuthAccountTypeComponent } from './components/auth-account-type/auth-account-type.component';
import { SvgBoxComponent } from './components/svg-box/svg-box.component';
@NgModule({
  declarations: [
    AuthBackgroundComponent,
    InputFieldComponent,
    ProgressIndicatorComponent,
    ButtonComponent,
    AuthDropdownComponent,
    AuthAccountTypeComponent,
    SvgBoxComponent,
  ],
  imports: [CommonModule],
  exports: [
    AuthBackgroundComponent,
    InputFieldComponent,
    ProgressIndicatorComponent,
    ButtonComponent,
    AuthDropdownComponent,
    AuthAccountTypeComponent,
    SvgBoxComponent,
  ],
})
export class SharedModule {}
