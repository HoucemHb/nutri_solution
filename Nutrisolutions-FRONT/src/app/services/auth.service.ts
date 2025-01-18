import { inject, Injectable } from '@angular/core';
import { ClientModel, UserRoleEnum } from '../models/client.model';
import { NutritionistModel } from '../models/nutritionist.model';
import { ToastrService } from 'ngx-toastr';
import { UserModel } from '../models/user.model';
import { APP_API, APP_CONST } from '../core/constants/constants.config';
import { Observable } from 'rxjs';
import { HttpBackend, HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private isAuthenticated = true;
  private userRole: string = 'client';
  toastr = inject(ToastrService);
  http = inject(HttpClient);
  apiUrl = APP_API.base_url + '/auth';
  router = inject(Router);
  private addUser(user: UserModel): Observable<UserModel> {
    return this.http.post<UserModel>(`${this.apiUrl}/signup`, user);
  }
  signupUser(user: UserModel): void {
    this.addUser(user).subscribe({
      next: (response) => {
        this.toastr.success('User Signed up successfully', 'Success');
        this.login(user.email, user.getPass());
      },
      error: (error) => {
        this.toastr.error('An error occurred', 'Error');
      },
    });
    this.userRole = user.role;
  }
  signupNutritionist(nutritionist: NutritionistModel): void {
    this.addUser(nutritionist).subscribe({
      next: (response) => {
        // this.toastr.success('User created successfully', 'Success');
        this.login(nutritionist.email, nutritionist.getPass());
      },
      error: (error) => {
        this.toastr.error('An error occurred', 'Error');
      },
    });

    this.userRole = nutritionist.role;
  }

  login(email: string, password: string): void {
    const credentials = { email: email, password: password };
    this.http.post(`${this.apiUrl}/login`, credentials).subscribe({
      next: (response: any) => {
        this.toastr.success('Login successful', 'Success');
        const token = response.accessToken;
        const user = response.user as UserModel;
        localStorage.setItem(APP_CONST.tokenLocalStorage, token);
        localStorage.setItem(APP_CONST.role, user.role);
        console.log('====================================');
        console.log('role is', user.role);
        console.log('====================================');
        if (user.role === UserRoleEnum.CLIENT) {
          this.router.navigate(['/client-home']);
        } else if (user.role === UserRoleEnum.NUTRITIONIST) {
          this.router.navigate(['/nutritionist-home']);
        } else {
          this.router.navigate(['/admin-home']);
        }
      },
      error: (error) => {
        const errorMessage = error?.error?.message || 'An error occurred';
        this.toastr.error(errorMessage, 'Error');
      },
    });
    this.isAuthenticated = true;
    localStorage.setItem('isAuthenticated', 'true');
  }

  logout(): void {
    this.isAuthenticated = false;
    this.userRole = '';
    localStorage.clear();
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('isAuthenticated') === 'true';
  }

  getUserRole(): string {
    return localStorage.getItem('role') || 'client';
  }
}
