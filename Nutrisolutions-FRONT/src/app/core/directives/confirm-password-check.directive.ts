import {
  Directive,
  ElementRef,
  HostListener,
  inject,
  Input,
  Renderer2,
  SimpleChanges,
} from '@angular/core';
import { LoggerService } from 'src/app/services/logger.service';

@Directive({
  selector: '[appConfirmPasswordCheck]',
})
export class ConfirmPasswordCheckDirective {
  @Input('applyConfirmPassword') applyConfirmPassword: boolean = false;
  @Input('password') password: any;

  private noteElement: HTMLElement | null = null;
  logger = inject(LoggerService);
  constructor(private el: ElementRef, private renderer: Renderer2) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['applyConfirmPassword']) {
      if (this.applyConfirmPassword) {
        this.logger.info('applying confirm pass');

        this.noteElement = this.renderer.createElement('small');
        this.logger.info('created small tag');

        this.renderer.addClass(this.noteElement, 'input-note');
        const inputHeader = this.el.nativeElement
          .closest('.input-field-container')
          ?.querySelector('.input-header');
        if (inputHeader) {
          // Append the note element to the input-header container
          this.renderer.appendChild(inputHeader, this.noteElement);
        }
      }
    }
  }

  @HostListener('input', ['$event.target.value'])
  onInput(value: string) {
    if (this.noteElement && this.applyConfirmPassword)
      this.checkPasswordMatch(value);
  }

  private checkPasswordMatch(confirmPassword: string) {
    this.logger.debug('confirm pass :' + confirmPassword);
    this.logger.debug('pass :' + this.password);

    if (!confirmPassword) {
      this.renderer.setProperty(
        this.noteElement,
        'textContent',
        'Required Field..'
      );
      this.renderer.removeClass(this.noteElement, 'valid-input-note');
      this.renderer.addClass(this.noteElement, 'error-input-note');
      return;
    }

    if (confirmPassword != this.password) {
      this.renderer.setProperty(
        this.noteElement,
        'textContent',
        'Password Mismatch'
      );
      this.renderer.removeClass(this.noteElement, 'valid-input-note');
      this.renderer.addClass(this.noteElement, 'error-input-note');
    } else {
      this.renderer.setProperty(this.noteElement, 'textContent', '');
      this.renderer.removeClass(this.noteElement, 'valid-input-note');
      this.renderer.removeClass(this.noteElement, 'error-input-note');
    }
  }
}
