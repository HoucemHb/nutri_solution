import { Component, inject, Input } from '@angular/core';
import { Router } from '@angular/router';
import { NutritionistModel } from 'src/app/models/nutritionist.model';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-nutritionist-item',
  templateUrl: './nutritionist-item.component.html',
  styleUrls: ['./nutritionist-item.component.css'],
})
export class NutritionistItemComponent {
  base_url = environment.apiUrl;
  @Input({ required: true }) nutritionist!: NutritionistModel;
  router = inject(Router);
  openPlanning = (): void => {
    this.router.navigate([`/nutritionnists/${this.nutritionist.id}/planning`]);
  };
}
