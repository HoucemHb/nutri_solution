import { Pipe, PipeTransform } from '@angular/core';
import {
  TrieEnum,
  StatusEnum,
  StatusEnumFilter,
} from 'src/app/models/nutritionist.model';
//! Ce pipe a été initialement créé pour filtrer les recettes localement.
//! Cependant, le filtrage est maintenant effectué directement dans la requête API.
@Pipe({
  name: 'nutritionistsTableFilter',
})
export class NutritionistsTableFilterPipe implements PipeTransform {
  transform(
    nutritionists: any[],
    searchQuery: string,
    statusFilter: StatusEnumFilter,
    dateFilter: TrieEnum
  ): any[] {
    if (!nutritionists) {
      return [];
    }

    let filteredNutritionists = nutritionists;

    // Filter by search query
    if (searchQuery) {
      filteredNutritionists = filteredNutritionists.filter((nutritionist) => {
        return (
          nutritionist.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
          nutritionist.address
            .toLowerCase()
            .includes(searchQuery.toLowerCase()) ||
          nutritionist.phone
            .toLowerCase()
            .includes(searchQuery.toLowerCase()) ||
          nutritionist.email
            .toLowerCase()
            .includes(searchQuery.toLowerCase()) ||
          nutritionist.certificate
            .toLowerCase()
            .includes(searchQuery.toLowerCase())
        );
      });
    }

    // Filter by status
    if (statusFilter && statusFilter !== StatusEnumFilter.ALL) {
      filteredNutritionists = filteredNutritionists.filter(
        (nutritionist) =>
          nutritionist.status.toLowerCase() === statusFilter.toLowerCase()
      );
    }

    // Filter and sort by date (addedAt)
    if (dateFilter && dateFilter !== TrieEnum.ALL) {
      filteredNutritionists = filteredNutritionists.sort((a, b) => {
        const dateA = new Date(a.addedAt).getTime();
        const dateB = new Date(b.addedAt).getTime();

        if (dateFilter === TrieEnum.PlusRecents) {
          return dateB - dateA; // Sort descending
        } else if (dateFilter === TrieEnum.PlusAnciens) {
          return dateA - dateB; // Sort ascending
        }
        return 0; // No sorting for 'ALL'
      });
    }

    return filteredNutritionists;
  }
}
