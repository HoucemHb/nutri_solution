import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AuthModule } from './auth/auth.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RecipesModule } from './features/recipes/recipes.module';
import { SharedModule } from './shared/shared.module';
import { NutritionistsModule } from './features/nutritionists/nutritionists.module';
import { ToastrModule } from 'ngx-toastr';
import { HomeModule } from './features/home/home.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { PlanningComponent } from './features/planning/planning.component';
import { ProfileModule } from './features/profile/profile.module';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { RouterLink, RouterModule, RouterOutlet } from '@angular/router';
import { TokenInterceptor } from './core/interceptors/token.interceptor';
import { CoreModule } from './core/core.module';
import { UnderConstructionComponent } from './features/under-construction/under-construction.component';
import { MessengerComponent } from './features/messenger/messenger/messenger.component';
import { MessengerModule } from './features/messenger/messenger.module';

@NgModule({
  declarations: [AppComponent, PlanningComponent, UnderConstructionComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    AuthModule,
    FormsModule,
    RecipesModule,
    NutritionistsModule,
    MessengerModule,
    SharedModule,
    ProfileModule,
    ReactiveFormsModule,
    ToastrModule.forRoot({
      timeOut: 3000, // Notification duration (in ms)
      positionClass: 'toast-top-right', // Position of notifications
      preventDuplicates: true, // Prevent duplicate notifications
      closeButton: true, // Show close button in the notification
    }),
    HomeModule,
    BrowserAnimationsModule,
    HttpClientModule,
    RouterModule,
    RouterOutlet,
    RouterLink,
    CoreModule,
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
