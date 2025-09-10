import { HttpClient, HttpParams } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { ClientModel } from '../models/client.model';
import { SlotModel } from '../models/slot.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class ClientService {
  private clients: ClientModel[] = [];

  #clients: ClientModel[] = [];

  apiUrl = environment.apiUrl + '/clients';
  #selectPatientSubject$ = new Subject<ClientModel>();
  selectPatient$ = this.#selectPatientSubject$.asObservable();

  constructor() {}
  http = inject(HttpClient);

  selectPatient(patient: ClientModel) {
    this.#selectPatientSubject$.next(patient);
  }

  getAllClients(): Observable<ClientModel[]> {
    return this.http.get<ClientModel[]>(this.apiUrl);
  }
  getClientsCount(): Observable<{ total: number }> {
    return this.http.get<{ total: number }>(this.apiUrl + '/count'); // Correct type for the response
  }

  getClientById(id: string): Observable<ClientModel> {
    return this.http.get<ClientModel>(`${this.apiUrl}/${id}`);
  }
  deleteClient(id: string): Observable<{ count: number }> {
    return this.http.delete<{ count: number }>(`${this.apiUrl}/${id}`);
  }

  updateClient(
    id: string,
    nutritionnist: ClientModel
  ): Observable<ClientModel> {
    return this.http.patch<ClientModel>(`${this.apiUrl}/${id}`, nutritionnist);
  }

  addRecipeToFavourite(
    recipeID: string,
    clientId: string
  ): Observable<ClientModel> {
    return this.http.post<ClientModel>(`${this.apiUrl}/${clientId}/favorites`, {
      recipeId: recipeID,
    });
  }

  getAppointment(
    clientId: string,
    nutritionnistId: string,
    appointmentNumber: number = 0
  ): Observable<SlotModel> {
    let params = new HttpParams();

    // Append the query parameter if appointementNumber is specified
    if (appointmentNumber > 0) {
      params = params.set('appointmentNumber', appointmentNumber);
    }
    return this.http.get<SlotModel>(
      `${this.apiUrl}/${clientId}/appointments/${nutritionnistId}`,
      { params }
    );
  }
  getLastReservedSlot(clientId: string): Observable<SlotModel | null> {
    return this.http.get<SlotModel | null>(
      `${this.apiUrl}/${clientId}/last-reserved-slot`
    );
  }
}
