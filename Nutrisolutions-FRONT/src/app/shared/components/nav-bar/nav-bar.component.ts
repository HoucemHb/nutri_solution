import {
  Component,
  ElementRef,
  ViewChild,
  AfterViewInit,
  inject,
} from '@angular/core';
import { Router } from '@angular/router';
import { ro } from '@faker-js/faker/.';
import { UserRoleEnum } from 'src/app/models/client.model';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css'],
})
export class NavBarComponent implements AfterViewInit {
  @ViewChild('toggle') toggle!: ElementRef;
  @ViewChild('itemsTitles') itemsTitles!: ElementRef;
  @ViewChild('navBar') navBar!: ElementRef;
  @ViewChild('itemsIcons') itemsIcons!: ElementRef;
  @ViewChild('logo') logo!: ElementRef;
  @ViewChild('logout') logout!: ElementRef;
  authService = inject(AuthService);
  ngOnInit() {
    const role = this.authService.getUserRole();
    const nutritionistId = this.authService.getUserId();
    switch (role) {
      case UserRoleEnum.CLIENT:
        this.menuItems = [
          { title: 'Acceuil', iconClass: 'fas fa-home', route: '/client-home' },
          { title: 'Profile', iconClass: 'fas fa-user', route: '/profile' },
          {
            title: 'Recettes',
            iconClass: 'fas fa-utensils',
            route: '/recipes',
          },
          {
            title: 'Nutritionnistes',
            iconClass: 'fas fa-user-md',
            route: '/nutritionists',
          },
          {
            title: 'Messenger',
            iconClass: 'fab fa-facebook-messenger',
            route: '/messenger',
          },
          { title: 'Gallery', iconClass: 'fas fa-image', route: '/gallery' },
          {
            title: 'Analytics',
            iconClass: 'fas fa-chart-line',
            route: '/analytics',
          },
          { title: 'Settings', iconClass: 'fas fa-cog', route: '/settings' },
        ];
        break;
      case UserRoleEnum.NUTRITIONIST:
        this.menuItems = [
          {
            title: 'Acceuil',
            iconClass: 'fas fa-home',
            route: '/nutritionist-home',
          },
          {
            title: 'Recettes',
            iconClass: 'fas fa-utensils',
            route: '/recipes',
          },
          {
            title: 'Planning',
            iconClass: 'fa-solid fa-calendar-days',
            route: `/nutritionnists/${nutritionistId}/planning`,
          },
          {
            title: 'Messenger',
            iconClass: 'fab fa-facebook-messenger',
            route: '/messenger',
          },
          { title: 'Gallery', iconClass: 'fas fa-image', route: '/gallery' },
          {
            title: 'Analytics',
            iconClass: 'fas fa-chart-line',
            route: '/analytics',
          },
          { title: 'Settings', iconClass: 'fas fa-cog', route: '/settings' },
        ];
        break;

      default:
        this.menuItems = [
          { title: 'Acceuil', iconClass: 'fas fa-home', route: '/admin-home' },
          {
            title: 'Recettes',
            iconClass: 'fas fa-utensils',
            route: '/recipes',
          },

          {
            title: 'Messenger',
            iconClass: 'fab fa-facebook-messenger',
            route: '/messenger',
          },
          { title: 'Gallery', iconClass: 'fas fa-image', route: '/gallery' },
          {
            title: 'Analytics',
            iconClass: 'fas fa-chart-line',
            route: '/analytics',
          },
          { title: 'Settings', iconClass: 'fas fa-cog', route: '/settings' },
        ];
        break;
    }
  }
  menuItems = [
    { title: 'Acceuil', iconClass: 'fas fa-home', route: '/client-home' },
    { title: 'Profile', iconClass: 'fas fa-user', route: '/profile' },
    { title: 'Recettes', iconClass: 'fas fa-utensils', route: '/recipes' },
    {
      title: 'Nutritionnistes',
      iconClass: 'fas fa-user-md',
      route: '/nutritionists',
    },
    {
      title: 'Messenger',
      iconClass: 'fab fa-facebook-messenger',
      route: '/messenger',
    },
    { title: 'Gallery', iconClass: 'fas fa-image', route: '/gallery' },
    { title: 'Analytics', iconClass: 'fas fa-chart-line', route: '/analytics' },
    { title: 'Settings', iconClass: 'fas fa-cog', route: '/settings' },
  ];

  selectedItem: number | null = null;
  isHovered: boolean = false;

  selectItem(index: number): void {
    this.selectedItem = index;
  }

  ngAfterViewInit(): void {
    this.toggle.nativeElement.addEventListener(
      'click',
      this.onToggleClick.bind(this)
    );
  }

  onToggleClick(): void {
    this.itemsTitles.nativeElement.classList.toggle('active');
    this.navBar.nativeElement.classList.toggle('active');
    this.itemsIcons.nativeElement.classList.toggle('active');
    this.logo.nativeElement.classList.toggle('active');
    this.logout.nativeElement.classList.toggle('active');
    this.toggle.nativeElement.classList.toggle('active');
  }

  router = inject(Router);
  signout = (): void => {
    this.authService.logout();
    this.router.navigate(['/login']);
  };
}
