import {
  Component,
  ElementRef,
  EventEmitter,
  Input,
  Output,
  ViewChild,
} from '@angular/core';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-upload-image',
  templateUrl: './upload-image.component.html',
  styleUrls: ['./upload-image.component.css'],
})
export class UploadImageComponent {
  @ViewChild('fileInput', { static: false }) fileInput!: ElementRef;
  @Input() uploadedImage: string = '';
  @Input() acceptedFileTypes: string = 'image/*'; // Default to images
  @Output() fileSelected = new EventEmitter<File>();
  base_url = environment.apiUrl;

  @Input() uploadedFileName: string = ''; // For non-image file names
  isImage: boolean = true; // Determines if the file is an image
  ngOnInit() {
    this.isImage = this.uploadedImage ? true : false;
  }
  triggerFileInput(): void {
    if (this.fileInput?.nativeElement) {
      this.fileInput.nativeElement.click();
    }
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      this.fileSelected.emit(file); // Emit the selected file to the parent component

      const fileType = file.type;
      this.isImage = fileType.startsWith('image/');

      if (this.isImage) {
        // Preview the image
        const reader = new FileReader();
        reader.onload = (e: ProgressEvent<FileReader>) => {
          this.uploadedImage = e.target?.result as string;
        };
        reader.readAsDataURL(file);
      } else {
        // Handle non-image files (e.g., PDFs)
        this.uploadedImage = ''; // Clear the image preview
        this.uploadedFileName = file.name;
      }
    }
  }

  getImageUrl(): string {
    return this.uploadedImage.includes('/uploads')
      ? `${this.base_url}${this.uploadedImage}`
      : this.uploadedImage;
  }
}
