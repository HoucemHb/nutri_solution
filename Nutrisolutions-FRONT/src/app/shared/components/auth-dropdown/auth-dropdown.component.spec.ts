import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AuthDropdownComponent } from './auth-dropdown.component';

describe('AuthDropdownComponent', () => {
  let component: AuthDropdownComponent;
  let fixture: ComponentFixture<AuthDropdownComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AuthDropdownComponent]
    });
    fixture = TestBed.createComponent(AuthDropdownComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
