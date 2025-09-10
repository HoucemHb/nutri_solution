import { Component, inject, Input } from '@angular/core';
import {
  NavigationEnd,
  NavigationError,
  NavigationStart,
  Router,
} from '@angular/router';
import {
  CategoryEnum,
  ObjectifEnum,
  RecipeModel,
} from 'src/app/models/recipe.model';
import { LoggerService } from 'src/app/services/logger.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-recipe-item',
  templateUrl: './recette-item.component.html',
  styleUrls: ['./recette-item.component.css'],
})
export class RecetteItemComponent {
  base_url = environment.apiUrl;
  @Input({ required: true }) recipe!: RecipeModel;
  logger = inject(LoggerService);
  router = inject(Router);
  ngOnInit() {
    this.router.events.subscribe((event) => {
      if (event instanceof NavigationStart) {
        // Log when navigation starts
        this.logger.log(`Navigation started to: ${event.url}`);
      } else if (event instanceof NavigationEnd) {
        // Log when navigation ends
        this.logger.log(`Navigation ended at: ${event.url}`);
      } else if (event instanceof NavigationError) {
        // Log if there's an error in navigation
        this.logger.log(`Navigation error: ${event.error}`);
      }
    });
  }
}
