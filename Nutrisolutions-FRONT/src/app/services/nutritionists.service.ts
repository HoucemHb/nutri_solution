import { inject, Injectable } from '@angular/core';
import { NutritionistModel, StatusEnum } from '../models/nutritionist.model';
// import { generateFakeNutritionist } from '../core/helpers/faker.helper';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ClientModel } from '../models/client.model';
import { ExperienceEnum } from '../models/recipe.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class NutritionistsService {
  private nutritionists: NutritionistModel[] = [];

  #nutritionists: NutritionistModel[] = [];

  apiUrl = environment.apiUrl + '/nutritionists';

  constructor() {}
  http = inject(HttpClient);

  getAllNutritionists(
    page: number = 1,
    limit: number = 12,
    searchText?: string,
    experience?: ExperienceEnum,
    status?: StatusEnum
  ): Observable<{
    data: NutritionistModel[];
    total: number;
  }> {
    let params = new HttpParams()
      .set('page', page.toString())
      .set('limit', limit.toString());
    if (searchText?.trim()) {
      params = params.set('searchText', searchText.trim());
    }
    if (experience) {
      params = params.set('experience', experience);
    }
    if (status) {
      params = params.set('status', status);
    }
    return this.http.get<{
      data: NutritionistModel[];
      total: number;
    }>(this.apiUrl, { params });
  }
  getNutritionistsCount(): Observable<{ total: number }> {
    return this.http.get<{ total: number }>(this.apiUrl + '/count');
  }
  getBestNutritionists(): Observable<NutritionistModel[]> {
    return this.http.get<NutritionistModel[]>(this.apiUrl + '/top');
  }
  getNutritionistById(id: string): Observable<NutritionistModel> {
    return this.http.get<NutritionistModel>(`${this.apiUrl}/${id}`);
  }
  getPatientsByNutritionist(id: string): Observable<ClientModel[]> {
    return this.http.get<ClientModel[]>(`${this.apiUrl}/${id}/patients`);
  }
  deleteNutritionist(id: string): Observable<{ count: number }> {
    return this.http.delete<{ count: number }>(`${this.apiUrl}/${id}`);
  }
  // addNutritionist(
  //   nutritionnist: NutritionistModel
  // ): Observable<NutritionistModel> {
  //   return this.http.post<NutritionistModel>(this.apiUrl, nutritionnist);
  // }
  updateNutritionist(
    id: string,
    status: StatusEnum
  ): Observable<NutritionistModel> {
    return this.http.patch<NutritionistModel>(`${this.apiUrl}/${id}`, {
      status,
    });
  }

  // getAllNutritionists(): NutritionistModel[] {
  //   return this.nutritionists.length
  //     ? this.nutritionists
  //     : this.generateFakeNutritionistList(15);
  // }
  // // Get all nutritionists
  // getBestNutritionists(): NutritionistModel[] {
  //   return this.generateFakeNutritionistList(4);
  // }

  // generateFakeNutritionistList(count: number): NutritionistModel[] {
  //   return Array.from({ length: count }, () => generateFakeNutritionist());
  // }

  // // Add a new nutritionist
  // addNutritionist(nutritionist: NutritionistModel): void {
  //   this.nutritionists.push(nutritionist);
  // }

  // // Find nutritionist by ID
  // getNutritionistById(id: string): NutritionistModel | undefined {
  //   return this.nutritionists.find((nutritionist) => nutritionist.id === id);
  // }

  // // Update a nutritionist
  // updateNutritionist(
  //   id: string,
  //   updatedData: Partial<NutritionistModel>
  // ): void {
  //   const index = this.nutritionists.findIndex(
  //     (nutritionist) => nutritionist.id === id
  //   );
  //   if (index > -1) {
  //     this.nutritionists[index] = {
  //       ...this.nutritionists[index],
  //       ...updatedData,
  //     };
  //   }
  // }

  // // Delete a nutritionist
  // deleteNutritionist(id: string): void {
  //   this.nutritionists = this.nutritionists.filter(
  //     (nutritionist) => nutritionist.id !== id
  //   );
  // }
}
