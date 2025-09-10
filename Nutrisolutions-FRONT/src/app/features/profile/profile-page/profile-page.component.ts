import { Component, inject, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { GetAgePipe } from 'src/app/core/pipes/get-age.pipe';
import { AppUtils } from 'src/app/core/utils/functions.utils';
import { ClientModel } from 'src/app/models/client.model';
import { RecipeModel } from 'src/app/models/recipe.model';
import { SlotModel } from 'src/app/models/slot.model';
import { AuthService } from 'src/app/services/auth.service';
import { ClientService } from 'src/app/services/client.service';
import { LoggerService } from 'src/app/services/logger.service';
import { RecipesService } from 'src/app/services/recipe.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-profile-page',
  templateUrl: './profile-page.component.html',
  styleUrls: ['./profile-page.component.css'],
})
export class ProfilePageComponent implements OnInit {
  recipesService = inject(RecipesService);
  client: ClientModel | null = null;
  recettes: RecipeModel[] | undefined;
  clientInfoItems: { icon: string; param: string }[] = [];
  authService = inject(AuthService);
  clientService = inject(ClientService);
  toastr = inject(ToastrService);
  base_url = environment.apiUrl;
  upcomingAppointement: SlotModel | null = null;
  logger = inject(LoggerService);
  constructor(private getAgePipe: GetAgePipe) {
    this.clientService.getClientById(this.authService.getUserId()).subscribe({
      next: (response) => {
        this.client = response;
        if (this.client.reservedSlots.length)
          this.upcomingAppointement =
            this.client.reservedSlots[this.client.reservedSlots.length - 1];
        this.updateClientInfoItems();
      },
      error: (err) => {
        this.logger.error('Upload Failed:', err);
      },
    });
  }

  ngOnInit() {
    this.recettes = this.recipesService.generateFakeRecipesList(4);
  }

  updateClientInfoItems() {
    if (this.client) {
      this.clientInfoItems = [
        { icon: 'fa-solid fa-user', param: this.client.gender ?? 'N/A' },
        {
          icon: 'fa-solid fa-cake-candles',
          param: this.getAgePipe.transform(this.client.birthDate),
        },
        { icon: 'fa-solid fa-envelope', param: this.client.email ?? 'N/A' },
        { icon: 'fa-solid fa-phone', param: this.client.phoneNumber ?? 'N/A' },
      ];
    }
  }
}
