import { inject, Injectable } from '@angular/core';
import { APP_API } from '../core/constants/constants.config';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Slot } from '../features/planning/planning.component';
import { SlotModel, CreateSlotModelDto } from '../models/slot.model';

@Injectable({
  providedIn: 'root',
})
export class PlanningService {
  apiUrl = APP_API.base_url + '/planning';

  constructor() {}
  http = inject(HttpClient);

  getUnavailableSlotsByNutritionist(
    nutritionistId: string
  ): Observable<SlotModel[]> {
    return this.http.get<SlotModel[]>(`${this.apiUrl}/${nutritionistId}`);
  }
  addSlot(slot: CreateSlotModelDto): Observable<SlotModel> {
    return this.http.post<SlotModel>(`${this.apiUrl}`, slot);
  }

  addNote(slotId: string, notes: string[]): Observable<SlotModel> {
    return this.http.patch<SlotModel>(`${this.apiUrl}/${slotId}`, { notes });
  }

  cancelSlotReservation(id: string): Observable<{ count: number }> {
    return this.http.delete<{ count: number }>(`${this.apiUrl}/${id}`);
  }
  // getClientById(id: string): Observable<ClientModel> {
  //   return this.http.get<ClientModel>(`${this.apiUrl}/${id}`);
  // }
  // deleteClient(id: string): Observable<{ count: number }> {
  //   return this.http.delete<{ count: number }>(`${this.apiUrl}/${id}`);
  // }

  // updateClient(
  //   id: string,
  //   nutritionnist: ClientModel
  // ): Observable<ClientModel> {
  //   return this.http.patch<ClientModel>(`${this.apiUrl}/${id}`, nutritionnist);
  // }

  // addRecipeToFavourite(
  //   recipeID: string,
  //   clientId: string
  // ): Observable<ClientModel> {
  //   return this.http.post<ClientModel>(`${this.apiUrl}/${clientId}/favorites`, {
  //     recipeId: recipeID,
  //   });
  // }
}
