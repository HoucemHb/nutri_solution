import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LandingPageComponent } from './features/landing/landing-page/landing-page.component';
import { LoginComponent } from './auth/login/login.component';
import { SignupComponent } from './auth/signup/signup.component';
import { NutritionistsListComponent } from './features/nutritionists/nutritionists-list/nutritionists-list.component';
import { authGuard } from './core/guards/auth.guard';
import { RecipesListComponent } from './features/recipes/recipes-list/recipes-list.component';
import { PlanningComponent } from './features/planning/planning.component';
import { ProfilePageComponent } from './features/profile/profile-page/profile-page.component';
import { AdminHomeComponent } from './features/home/admin-home/admin-home.component';
import { roleGuard } from './core/guards/role.guard';
import { HomePageComponent } from './features/home/home-page/home-page.component';
import { HomeNutritionisteComponent } from './features/home/home-nutritioniste/home-nutritioniste.component';
import { AddRecipeComponent } from './features/recipes/add-recipe/add-recipe.component';
import { ResetPasswordComponent } from './auth/reset-password/reset-password.component';
import { UserRoleEnum } from './models/client.model';
import { UnderConstructionComponent } from './features/under-construction/under-construction.component';
import { MessengerComponent } from './features/messenger/messenger/messenger.component';

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
  {
    path: 'messenger',
    component: MessengerComponent,

    canActivate: [authGuard],
  },

  { path: '**', component: UnderConstructionComponent, pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
