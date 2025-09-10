import { Component, inject } from '@angular/core';
import { FormControl } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import {
  combineLatest,
  startWith,
  debounceTime,
  distinctUntilChanged,
  switchMap,
} from 'rxjs';
import { AppUtils } from 'src/app/core/utils/functions.utils';
// import { generateFakeNutritionist } from 'src/app/core/helpers/faker.helper';
import {
  NutritionistModel,
  StatusEnum,
  StatusEnumFilter,
} from 'src/app/models/nutritionist.model';
import { ExperienceEnum } from 'src/app/models/recipe.model';
import { FileUploadService } from 'src/app/services/file-upload.service';
import { LoggerService } from 'src/app/services/logger.service';
import { NutritionistsService } from 'src/app/services/nutritionists.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-nutritionists-table',
  templateUrl: './nutritionists-table.component.html',
  styleUrls: [
    './nutritionists-table.component.css',
    '../../../../assets/css/list-common.css',
  ],
})
export class NutritionistsTableComponent {
  base_url = environment.apiUrl;
  searchControl: FormControl = new FormControl('');
  statusControl: FormControl = new FormControl(StatusEnumFilter.ALL);
  statusOptions = Object.values(StatusEnumFilter);
  statusEnum = StatusEnum;
  nutritionists: NutritionistModel[] = [];
  nutritionistService = inject(NutritionistsService);
  toastr = inject(ToastrService);
  totalNutritionistsCount: number = 0;
  currentPage: number = 1;
  limit: number = 12;
  isLoading: boolean = false;
  constructor() {
    this.nutritionistService
      .getAllNutritionists(this.currentPage, this.limit)
      .subscribe((response) => {
        this.nutritionists = response.data;
      });
  }
  logger = inject(LoggerService);
  ngOnInit() {
    this.statusControl = new FormControl(StatusEnumFilter.ALL);

    combineLatest([
      this.searchControl.valueChanges.pipe(
        startWith(''),
        debounceTime(300),
        distinctUntilChanged()
      ),
      this.statusControl.valueChanges.pipe(
        startWith(''),
        distinctUntilChanged()
      ),
    ])
      .pipe(
        switchMap(([searchText, status]) => {
          this.isLoading = true;
          this.logger.info('new call');
          return this.nutritionistService.getAllNutritionists(
            1,
            12,
            searchText,
            undefined,
            (status as StatusEnumFilter) == StatusEnumFilter.ALL ? '' : status
          );
        })
      )
      .subscribe({
        next: (response) => {
          this.nutritionists = response.data;
          this.totalNutritionistsCount = response.total;
          setTimeout(() => {
            this.isLoading = false;
          }, 500); // Reduce loading delay for a better UX
        },
        error: (error) => {
          this.toastr.error(AppUtils.getErrorMessage(error), 'Erreur');
          this.isLoading = false;
        },
      });
    this.fetchNutritionists();
  }
  fetchNutritionists() {
    this.isLoading = true;
    this.nutritionistService.getAllNutritionists(this.currentPage).subscribe({
      next: (response) => {
        this.nutritionists = response.data;
        this.totalNutritionistsCount = response.total;

        // H
        setTimeout(() => {
          this.isLoading = false;
        }, 1000);
      },
      error: (error) => {
        this.toastr.error(AppUtils.getErrorMessage(error), 'Erreur');
        this.isLoading = false; // H
      },
    });
  }
  updateStatus(nutritionist: NutritionistModel, newStatus: StatusEnum): void {
    this.nutritionistService
      .updateNutritionist(nutritionist.id!, newStatus)
      .subscribe({
        next: (response) => {
          // Success callback
          this.toastr.success('Statut mis à jour avec succès !');
          nutritionist.status = newStatus;
        },
        error: (error) => {
          // Error callback
          this.toastr.error(
            'Erreur lors de la mise à jour du statut',
            'Erreur'
          );
        },
      });
  }
  highlightText(content: string, search: string): string {
    if (!search) {
      return content;
    } // Return the original content if search is empty

    // Escape special characters in the search term
    const escapedSearch = search.replace(/[.*+?^=!:${}()|\[\]\/\\]/g, '\\$&');

    // Create a case-insensitive regex for the search term
    const regex = new RegExp(`(${escapedSearch})`, 'gi');

    // Wrap matches with a span
    return content.replace(
      regex,
      (match) => `<span class="highlight">${match}</span>`
    );
  }
  uploadService = inject(FileUploadService);
  downloadCertificate(filename: string) {
    this.uploadService.downloadCertificate(filename).subscribe({
      next: (blob) => {
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = filename; // Use the original filename
        link.click();
        URL.revokeObjectURL(link.href); // Clean up
      },
      error: (error) => {
        this.logger.error('Error downloading file:', error);
      },
    });
  }

  getTotalPageNumber() {
    return Math.ceil(this.totalNutritionistsCount / this.limit);
  }

  updatePage(index: number) {
    this.currentPage = index;
    this.isLoading = true;

    this.nutritionistService
      .getAllNutritionists(
        this.currentPage,
        this.limit,
        this.searchControl.value,
        undefined,
        (this.statusControl.value as StatusEnumFilter) == StatusEnumFilter.ALL
          ? ''
          : this.statusControl.value
      )
      .subscribe({
        next: (response) => {
          this.nutritionists = response.data;
          this.totalNutritionistsCount = response.total;
          // H
          setTimeout(() => {
            this.isLoading = false;
          }, 1000);
        },
        error: (error) => {
          this.toastr.error(AppUtils.getErrorMessage(error), 'Erreur');
          this.isLoading = false; // H
        },
      });
  }
}
