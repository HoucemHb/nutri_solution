import { Module } from '@nestjs/common';
import { RecipeController } from './recipe.controller';
import { RecipesService } from './recipe.service';
import { RecipeEntity } from './recipe-entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  controllers: [RecipeController],
  providers: [RecipesService],
  imports: [
    TypeOrmModule.forFeature([RecipeEntity]),
    // ServeStaticModule.forRoot({
    //   rootPath: join(process.cwd(), 'uploads', 'recipes'),
    //   serveRoot: '/uploads/recipes',
    // }),
  ],
  exports: [],
})
export class RecipeModule {}
