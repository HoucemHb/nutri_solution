import { inject, Injectable } from '@angular/core';
import { NutritionistModel } from '../models/nutritionist.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { generateFakeRecipe } from '../core/helpers/faker.helper';
import {
  CategoryEnum,
  ObjectifEnum,
  RecipeModel,
} from '../models/recipe.model';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class RecipesService {
  #recipes: RecipeModel[] = [];

  apiUrl = environment.apiUrl + '/recipes';

  constructor() {}
  http = inject(HttpClient);

  getAllRecipes(
    page: number = 1,
    limit: number = 12,
    searchText?: string,
    objectif?: ObjectifEnum,
    category?: CategoryEnum
  ): Observable<{ data: RecipeModel[]; total: number }> {
    let params = new HttpParams()
      .set('page', page.toString())
      .set('limit', limit.toString());

    if (searchText?.trim()) {
      params = params.set('searchText', searchText.trim());
    }
    if (objectif) {
      params = params.set('objectif', objectif);
    }
    if (category) {
      params = params.set('categorie', category);
    }

    return this.http.get<{ data: RecipeModel[]; total: number }>(this.apiUrl, {
      params,
    });
  }
  getRecipesCount(): Observable<{ total: number }> {
    return this.http.get<{ total: number }>(this.apiUrl + '/count');
  }
  getRecipeById(id: string): Observable<RecipeModel> {
    return this.http.get<RecipeModel>(`${this.apiUrl}/${id}`);
  }
  deleteRecipe(id: string): Observable<{ count: number }> {
    return this.http.delete<{ count: number }>(`${this.apiUrl}/${id}`);
  }
  addRecipe(recipe: RecipeModel): Observable<RecipeModel> {
    return this.http.post<RecipeModel>(this.apiUrl, recipe);
  }
  updateRecipe(id: string, recipe: RecipeModel): Observable<RecipeModel> {
    return this.http.patch<RecipeModel>(`${this.apiUrl}/${id}`, recipe);
  }

  /**
   *
   * Retourne un liste fictive de cvs
   *
   * @returns RecipeModel[]
   *
   */

  // Get all recipes
  // getAllRecipes(): RecipeModel[] {
  //   return this.recipes.length
  //     ? this.recipes
  //     : this.generateFakeRecipesList(12);
  // }

  getPopularRecipes(): RecipeModel[] {
    return this.generateFakeRecipesList(4);
  }

  generateFakeRecipesList(count: number): RecipeModel[] {
    return Array.from({ length: count }, () => generateFakeRecipe());
  }

  // addRecipe(recipe: RecipeModel): void {
  //   this.recipes.push(recipe);
  // }

  // Find nutritionist by ID
  // getRecipeById(id: string): RecipeModel | undefined {
  //   return this.recipes.find((recipe) => recipe.id === id);
  // }

  // updateRecipe(id: string, updatedData: Partial<NutritionistModel>): void {
  //   const index = this.recipes.findIndex((recipe) => recipe.id === id);
  //   if (index > -1) {
  //     this.recipes[index] = {
  //       ...this.recipes[index],
  //       ...updatedData,
  //     };
  //   }
  // }

  // deleteRecipesist(id: string): void {
  //   this.recipes = this.recipes.filter((recipe) => recipe.id !== id);
  // }
}
