import {
  Controller,
  Post,
  Param,
  Body,
  Get,
  Query,
} from '@nestjs/common';
import { Client } from './client.entity';
import { ClientService } from './client.service';
import { Public } from 'src/auth/guards/auth.guard';
import { ReservedSlotService } from 'src/planning/reserved-slot/reserved-slot.service';
import { RecipeEntity } from 'src/recipe/recipe-entity';

@Public()
@Controller('clients')
export class ClientController {
  constructor(
    protected readonly clientService: ClientService,
    protected readonly reservedSlotService: ReservedSlotService,
  ) {}

  /**
   * Endpoint pour obtenir tous les clients
   */
  @Get()
  async findAll(): Promise<Client[]> {
    return this.clientService.findAll();
  }

  /**
   * Endpoint pour obtenir le nombre total de clients
   */
  @Get('count')
  async countNutritionists(): Promise<{ total: number }> {
    return this.clientService.countClients();
  }

  /**
   * Endpoint pour obtenir un client par ID
   */
  @Get(':id')
  async findOne(@Param('id') id: string): Promise<Client> {
    return this.clientService.findOneById(id);
  }

  /**
   * Endpoint pour ajouter une recette aux favoris d'un client
   */
  @Post(':clientId/favorites')
  async addFavorite(
    @Param('clientId') clientId: string,
    @Body('recipeId') recipeId: string,
  ) {
    return this.clientService.addFavoriteRecipe(clientId, recipeId);
  }

  /**
   * Endpoint pour obtenir les recettes favorites d'un client
   */
  @Get(':clientId/favorites')
  async getFavourites(@Param('clientId') clientId: string):Promise<RecipeEntity[]>  {
    return this.clientService.getFavouriteRecipes(clientId);
  }

  /**
   * Endpoint pour obtenir les rendez-vous d'un client avec un nutritionniste
   */
  @Get(':clientId/appointments/:nutritionistId')
  async getAppointements(
    @Param('clientId') clientId: string,
    @Param('nutritionistId') nutritionistId: string,
    @Query('appointmentNumber') appointmentNumber: number,
  ) {
    return this.reservedSlotService.getAppointments(
      clientId,
      nutritionistId,
      appointmentNumber,
    );
  }
}
