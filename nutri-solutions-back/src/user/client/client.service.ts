import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ClientEntity } from './client.entity';
import { RecipeEntity } from 'src/recipe/recipe-entity';
import { CreateClientDto } from './dtos/create-client.dto';
import { UpdateClientDto } from './dtos/update-client.dto';
import { UserService } from '../user.service';
import { UserEntity } from '../user.entity';

@Injectable()
export class ClientService extends UserService {
  constructor(
    @InjectRepository(ClientEntity)
    private readonly clientRepository: Repository<ClientEntity>,
    @InjectRepository(RecipeEntity)
    private readonly recipeRepository: Repository<RecipeEntity>,
    @InjectRepository(UserEntity)
    protected readonly userRepository: Repository<UserEntity>,
  ) {
    super(userRepository);
  }

  // Get all clients
  async findAll(): Promise<ClientEntity[]> {
    return this.clientRepository.find({
      relations: ['favoriteRecipes'], // Include related favorite recipes
    });
  }

  // Get a specific client by ID
  async findOneById(id: string): Promise<ClientEntity> {
    const client = await this.clientRepository.findOne({
      where: { id },
      relations: ['favoriteRecipes'], // Include related favorite recipes
    });

    if (!client) {
      throw new NotFoundException(`Client with ID ${id} not found`);
    }
    return client;
  }

  // // Create a new client
  // async create(createClientDto: CreateClientDto): Promise<ClientEntity> {
  //   const newClient = this.clientRepository.create(createClientDto);
  //   return this.clientRepository.save(newClient);
  // }

  // Update an existing client
  // async update(
  //   id: string,
  //   updateClientDto: UpdateClientDto,
  // ): Promise<ClientEntity> {
  //   const client = await this.findOneById(id); // Ensure client exists
  //   Object.assign(client, updateClientDto); // Merge updates
  //   return this.clientRepository.save(client);
  // }

  // Add a favorite recipe for a client
  async addFavoriteRecipe(
    clientId: string,
    recipeId: string,
  ): Promise<ClientEntity> {
    const client = await this.findOneById(clientId); // Ensure client exists
    const recipe = await this.recipeRepository.findOne({
      where: { id: recipeId },
    });

    if (!recipe) {
      throw new NotFoundException(`Recipe with ID ${recipeId} not found`);
    }

    // Avoid duplicating recipes in the favorites
    if (!client.favoriteRecipes.some((r) => r.id === recipe.id)) {
      client.favoriteRecipes.push(recipe);
      await this.clientRepository.save(client);
    }

    return client;
  }
  async getFavouriteRecipes(clientId: string): Promise<RecipeEntity[]> {
    const client = await this.clientRepository.findOne({
      where: { id: clientId },
    }); // Ensure client exists

    if (!client) {
      throw new NotFoundException(`Client with ID ${clientId} not found`);
    }
    const recipes = client.favoriteRecipes;

    return recipes;
  }

  // Remove a favorite recipe for a client
  async removeFavoriteRecipe(
    clientId: string,
    recipeId: string,
  ): Promise<ClientEntity> {
    const client = await this.findOneById(clientId); // Ensure client exists
    const recipeIndex = client.favoriteRecipes.findIndex(
      (r) => r.id === recipeId,
    );

    if (recipeIndex === -1) {
      throw new NotFoundException(
        `Recipe with ID ${recipeId} is not in the client's favorites`,
      );
    }

    client.favoriteRecipes.splice(recipeIndex, 1); // Remove the recipe
    await this.clientRepository.save(client);

    return client;
  }
}