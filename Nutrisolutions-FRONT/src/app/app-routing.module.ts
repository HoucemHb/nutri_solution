import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LandingPageComponent } from './features/landing/landing-page/landing-page.component';
import { NutritionistsListComponent } from './features/nutritionists/nutritionists-list/nutritionists-list.component';
import { authGuard } from './core/guards/auth.guard';
import { ProfilePageComponent } from './features/profile/profile-page/profile-page.component';
import { AdminHomeComponent } from './features/home/admin-home/admin-home.component';
import { roleGuard } from './core/guards/role.guard';
import { HomePageComponent } from './features/home/home-page/home-page.component';
import { HomeNutritionisteComponent } from './features/home/home-nutritioniste/home-nutritioniste.component';
import { UserRoleEnum } from './models/client.model';
import { UnderConstructionComponent } from './shared/components/under-construction/under-construction.component';
import { LoginComponent } from './features/auth/login/login.component';
import { ResetPasswordComponent } from './features/auth/reset-password/reset-password.component';
import { SignupComponent } from './features/auth/signup/signup.component';
import { PlanningComponent } from './features/planning/planning/planning.component';

const routes: Routes = [
  { path: '', component: LandingPageComponent },
  { path: 'login', component: LoginComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'reset-password/:resetToken', component: ResetPasswordComponent },
  {
    path: 'nutritionists',
    component: NutritionistsListComponent,
    canActivate: [authGuard],
  },
  {
    path: 'recipes',
    loadChildren: () =>
      import('./features/recipes/recipes.module').then((m) => m.RecipesModule),
  },
  {
    path: 'nutritionnists/:nutritionistId/planning',
    component: PlanningComponent,
    canActivate: [authGuard],
  },
  {
    path: 'profile',
    component: ProfilePageComponent,
    canActivate: [authGuard],
  },
  {
    path: 'admin-home',
    component: AdminHomeComponent,
    canActivate: [authGuard, roleGuard],
    data: { roles: [UserRoleEnum.ADMIN] },
  },
  {
    path: 'client-home',
    component: HomePageComponent,
    canActivate: [authGuard, roleGuard],
    data: { roles: [UserRoleEnum.CLIENT] },
  },
  {
    path: 'nutritionist-home',
    component: HomeNutritionisteComponent,
    canActivate: [authGuard, roleGuard],
    data: { roles: [UserRoleEnum.NUTRITIONIST] },
  },

  { path: '**', component: UnderConstructionComponent, pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
