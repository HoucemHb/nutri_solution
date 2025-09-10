import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AppUtils } from 'src/app/core/utils/functions.utils';
import { UserRoleEnum } from 'src/app/models/client.model';
import { RecipeModel } from 'src/app/models/recipe.model';
import { AuthService } from 'src/app/services/auth.service';
import { ClientService } from 'src/app/services/client.service';
import { LoggerService } from 'src/app/services/logger.service';
import { RecipesService } from 'src/app/services/recipe.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-recipe-details',
  templateUrl: './recipe-details.component.html',
  styleUrls: [
    './recipe-details.component.css',
    '../../../../assets/css/list-common.css',
  ],
})
export class RecipeDetailsComponent implements OnInit {
  base_url = environment.apiUrl;
  recipe!: RecipeModel;
  items: { image: string; content: string }[] = []; // Additional recipe details
  recipeId: string | null = '';
  route = inject(ActivatedRoute);
  router = inject(Router);
  toastr = inject(ToastrService);
  clientService = inject(ClientService);
  authService = inject(AuthService);
  logger = inject(LoggerService);
  buttons = [
    {
      image: 'assets/images/downloads.png',
      text: 'Download recipe',
    },
    {
      image: 'assets/images/favourite.png',
      text: 'Add to favorite',
    },
    // { image: 'assets/images/question.png', text: 'Ask question' },
    {
      image: 'assets/images/question.png',
      text: 'Edit Recipe',
    },
  ];

  private recipesService = inject(RecipesService);

  checkedInstructions: Set<number> = new Set(); // Set to track checked instructions

  // Method to toggle the instruction state (checked or unchecked)
  toggleInstruction(index: number): void {
    if (this.checkedInstructions.has(index)) {
      this.checkedInstructions.delete(index); // Uncheck if already checked
    } else {
      this.checkedInstructions.add(index); // Check the instruction
    }
  }

  // Method to check if the instruction is checked
  isInstructionChecked(index: number): boolean {
    return this.checkedInstructions.has(index);
  }
  role: string = UserRoleEnum.CLIENT;

  ngOnInit(): void {
    this.recipeId = this.route.snapshot.paramMap.get('id');
    this.logger.debug('Recipe ID:', this.recipeId);
    this.loadRecipe(this.recipeId || '');
    this.role = this.authService.getUserRole();
  }

  private loadRecipe(id: string): void {
    this.recipesService.getRecipeById(id).subscribe((recipe: RecipeModel) => {
      this.recipe = recipe;
      this.populateItems();
    });
  }

  private populateItems(): void {
    if (!this.recipe) return;

    this.items = [
      {
        image: 'assets/images/doctor.png',
        content: 'Dr. ' + this.recipe.createdBy || 'Unknown',
      },
      {
        image: 'assets/images/goal.png',
        content: this.recipe.objectif || 'No objective provided',
      },
      {
        image: 'assets/images/chef.png',
        content: this.recipe.category || 'Uncategorized',
      },
      {
        image: 'assets/images/meal.png',
        content: this.recipe.preparationTime || 'N/A',
      },
      {
        image: 'assets/images/proteins.png',
        content: `${this.recipe.protein || 0} grammes`,
      },
      {
        image: 'assets/images/lipid.png',
        content: `${this.recipe.fat || 0} grammes`,
      },
      {
        image: 'assets/images/carbohydrate.png',
        content: `${this.recipe.carbohydrates || 0} grammes`,
      },
      {
        image: 'assets/images/calories.png',
        content: `${this.recipe.calories || 0} calories`,
      },
    ];
  }
  deleteRecipe() {
    if (this.recipeId) {
      this.recipesService.deleteRecipe(this.recipeId).subscribe(
        (response) => {
          this.toastr.success('Recette supprimée avec succès');
          this.router.navigate(['/recipes']);
        },
        (error) => {
          this.toastr.error('Erreur lors de la suppression de la recette');
          this.logger.error('Error deleting recipe:', error);
        }
      );
    }
  }

  addToFavourite() {
    this.clientService
      .addRecipeToFavourite(this.recipeId!, this.authService.getUserId())
      .subscribe({
        next: (client) => {
          this.toastr.success('Recette ajoutée aux favoris');
        },
        error: (error) => {
          this.toastr.error("Erreur lors de l'ajout de la recette aux favoris");
          this.logger.error('Error adding recipe to favourite:', error);
        },
      });
  }

  showFavoriteButton(): boolean {
    if (this.recipe)
      return (
        this.role === UserRoleEnum.CLIENT &&
        !this.recipe.favoritedByClient?.some(
          (client) => client.id === this.authService.getUserId()
        )
      );
    return true;
  }
}
