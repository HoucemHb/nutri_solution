import { inject, Injectable } from '@angular/core';
import { ClientModel, UserRoleEnum } from '../models/client.model';
import { NutritionistModel } from '../models/nutritionist.model';
import { ToastrService } from 'ngx-toastr';
import { UserModel } from '../models/user.model';
import { APP_CONST } from '../core/constants/constants.config';
import { Observable, subscribeOn } from 'rxjs';
import { HttpBackend, HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { AppUtils } from '../core/utils/functions.utils';
import { ClientService } from './client.service';
import { NutritionistsService } from './nutritionists.service';
import { LoggerService } from './logger.service';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private isAuthenticated = true;
  private userRole: string = 'client';
  toastr = inject(ToastrService);
  http = inject(HttpClient);
  apiUrl = environment.apiUrl + '/auth';
  router = inject(Router);
  logger = inject(LoggerService);
  private addUser(user: UserModel): Observable<UserModel> {
    return this.http.post<UserModel>(`${this.apiUrl}/signup`, user);
  }
  signupUser(user: UserModel): void {
    this.addUser(user).subscribe({
      next: (response) => {
        this.toastr.success('Utilisateur inscrit avec succès', 'Succès');
        if (user.role == UserRoleEnum.CLIENT)
          this.login(user.email, user.getPass());
        else
          this.toastr.info(
            "Veuillez attendre que l'administrateur approuve votre candidature.",
            'Validation de la candidature',
            {
              timeOut: 10000, // Stay for 10 seconds
            }
          );
        this.router.navigate(['/']);
      },
      error: (error) => {
        this.toastr.error(AppUtils.getErrorMessage(error), 'Erreur');
      },
    });
    this.userRole = user.role;
  }
  // signupNutritionist(nutritionist: NutritionistModel): void {
  //   this.addUser(nutritionist).subscribe({
  //     next: (response) => {
  //       this.toastr.success('User created successfully', 'Success');
  //       // this.login(nutritionist.email, nutritionist.getPass());
  //     },
  //     error: (error) => {
  //       this.toastr.error(AppUtils.getErrorMessage(error), 'Error');
  //     },
  //   });

  //   this.userRole = nutritionist.role;
  // }

  login(email: string, password: string): void {
    const credentials = { email: email, password: password };
    this.http.post(`${this.apiUrl}/login`, credentials).subscribe({
      next: (response: any) => {
        this.toastr.success('Connexion réussie', 'Succès');
        const token = response.accessToken;
        const user = response.user as UserModel;
        localStorage.setItem(APP_CONST.tokenLocalStorage, token);
        localStorage.setItem(APP_CONST.role, user.role);
        localStorage.setItem(APP_CONST.payloadIdKey, user.id!);
        localStorage.setItem(APP_CONST.nameLocalStorage, user.name!);
        this.logger.debug('role is', user.role);
        if (user.role === UserRoleEnum.CLIENT) {
          this.router.navigate(['/client-home']);
        } else if (user.role === UserRoleEnum.NUTRITIONIST) {
          this.router.navigate(['/nutritionist-home']);
        } else {
          this.router.navigate(['/admin-home']);
        }
      },
      error: (error) => {
        this.toastr.error(AppUtils.getErrorMessage(error), 'Erreur');
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

  resetPasswordRequest(email: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/request-password-reset`, {
      email,
    });
  }
  resetPassword(
    resetToken: string,
    oldPassword: string,
    newPassword: string
  ): Observable<string> {
    return this.http.post<string>(`${this.apiUrl}/reset-password`, {
      resetToken,
      oldPassword,
      newPassword,
    });
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('isAuthenticated') === 'true';
  }

  getUserRole(): string {
    return localStorage.getItem(APP_CONST.role) || 'client';
  }
  getUserId(): string {
    return localStorage.getItem(APP_CONST.payloadIdKey) || '';
  }
  getUserName(): string {
    return localStorage.getItem(APP_CONST.nameLocalStorage) || '';
  }
  clientService = inject(ClientService);
  nutritionistService = inject(NutritionistsService);

  getUserInfos(): Observable<UserModel> | undefined {
    const role = this.getUserRole();
    if (role === UserRoleEnum.CLIENT) {
      return this.clientService.getClientById(this.getUserId());
    } else if (role === UserRoleEnum.NUTRITIONIST) {
      return this.nutritionistService.getNutritionistById(this.getUserId());
    } else {
      return undefined;
    }
  }
}
