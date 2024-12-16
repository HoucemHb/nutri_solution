import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-input-field',
  templateUrl: './input-field.component.html',
  styleUrls: ['./input-field.component.css'],
})
export class InputFieldComponent {
  @Input() label: string = '';
  @Input() placeholder: string = ''; 
  @Input() type: string = 'text'; 
  @Input() isPassword: boolean = false; 
  @Input() formControlName: string = '';
  @Input() required: boolean = false; 

  isPasswordVisible: boolean = false;

  // Toggle password visibility
  togglePasswordVisibility() {
    this.isPasswordVisible = !this.isPasswordVisible;
  }
}
