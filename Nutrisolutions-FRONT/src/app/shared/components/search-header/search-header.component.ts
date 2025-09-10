import { Component, inject, Input } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { APP_CONST } from 'src/app/core/constants/constants.config';
import { UserModel } from 'src/app/models/user.model';
import { AuthService } from 'src/app/services/auth.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-search-header',
  templateUrl: './search-header.component.html',
  styleUrls: ['./search-header.component.css'],
})
export class SearchHeaderComponent {
  @Input() formControlName: FormControl = new FormControl('');
  base_url = environment.apiUrl;
  defaultImage = APP_CONST.defaultImageUrl;
  user: UserModel | undefined = undefined;
  authService = inject(AuthService);
  toastr = inject(ToastrService);
  ngOnInit() {
    this.authService.getUserInfos()?.subscribe({
      next: (response: UserModel) => {
        this.user = response;
      },
      error: (error) => {
        // Error callback
        this.toastr.error(
          "Erreur lors de la récupération de l'utilisateur",
          'Erreur'
        );
      },
    });
  }
  router = inject(Router);
  signout = (): void => {
    this.authService.logout();
    this.router.navigate(['/login']);
  };
}
