import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/features/recipes/widgets/recipe_item.dart';
import 'package:nutrisolutions_mobile/data/models/recipe_model.dart';

class RecipesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<RecipeModel> recipes = [
      RecipeModel(
        id: '1',
        name: 'Omelette au Fromage',
        description: 'Une omelette rapide et délicieuse au fromage.',
        ingredients: ['Œufs', 'Fromage râpé', 'Sel', 'Poivre', 'Beurre'],
        imageUrl: 'assets/images/recipe1.png',
        calories: 250,
        category: 'Petit Déjeuner', // <- plain string
        objectif: 'Maintenance', // <- plain string
        preparationTime: 'Moins de 15 minutes', // <- plain string
        createdBy: 'user123',
        createdAt: DateTime.now(),
        protein: 18,
        fat: 20,
        carbohydrates: 2,
        instructions: [
          'Battre les œufs avec du sel et du poivre.',
          'Faire fondre le beurre dans une poêle.',
          'Cuire les œufs et ajouter le fromage.',
          'Plier et servir chaud.'
        ],
        cookingNotes: ['Ne pas trop cuire pour garder la texture moelleuse.'],
        favoritedByClient: [],
      ),
      RecipeModel(
        id: '2',
        name: 'Salade César',
        description: 'Une salade classique, fraîche et croquante.',
        ingredients: [
          'Laitue romaine',
          'Poulet grillé',
          'Croûtons',
          'Parmesan',
          'Sauce César'
        ],
        imageUrl: 'assets/images/recipe2.png',
        calories: 450,
        category: 'Déjeuner',
        objectif: 'Perte de poids',
        preparationTime: '15-30 minutes',
        createdBy: 'user456',
        createdAt: DateTime.now(),
        protein: 30,
        fat: 25,
        carbohydrates: 15,
        instructions: [
          'Laver et couper la laitue.',
          'Ajouter le poulet grillé et les croûtons.',
          'Parsemer de parmesan.',
          'Assaisonner avec la sauce César.'
        ],
        cookingNotes: ['Utiliser un poulet bio pour une meilleure qualité.'],
        favoritedByClient: [],
      ),
      RecipeModel(
        id: '3',
        name: 'Spaghetti Bolognese',
        description: 'Un plat italien savoureux et réconfortant.',
        ingredients: [
          'Spaghetti',
          'Bœuf haché',
          'Tomates',
          'Oignons',
          'Ail',
          'Basilic'
        ],
        imageUrl: 'assets/images/recipe3.png',
        calories: 700,
        category: 'Diner',
        objectif: 'Prise de masse',
        preparationTime: '30-45 minutes',
        createdBy: 'user789',
        createdAt: DateTime.now(),
        protein: 40,
        fat: 20,
        carbohydrates: 70,
        instructions: [
          'Cuire les spaghetti selon les instructions du paquet.',
          'Faire revenir les oignons et l’ail.',
          'Ajouter le bœuf haché et cuire.',
          'Incorporer les tomates et laisser mijoter.',
          'Servir avec les pâtes et du basilic frais.'
        ],
        cookingNotes: ['Cuire les pâtes al dente pour un meilleur goût.'],
        favoritedByClient: [],
      ),
      RecipeModel(
        id: '1',
        name: 'Omelette au Fromage',
        description: 'Une omelette rapide et délicieuse au fromage.',
        ingredients: ['Œufs', 'Fromage râpé', 'Sel', 'Poivre', 'Beurre'],
        imageUrl: 'assets/images/recipe1.png',
        calories: 250,
        category: 'Petit Déjeuner', // <- plain string
        objectif: 'Maintenance', // <- plain string
        preparationTime: 'Moins de 15 minutes', // <- plain string
        createdBy: 'user123',
        createdAt: DateTime.now(),
        protein: 18,
        fat: 20,
        carbohydrates: 2,
        instructions: [
          'Battre les œufs avec du sel et du poivre.',
          'Faire fondre le beurre dans une poêle.',
          'Cuire les œufs et ajouter le fromage.',
          'Plier et servir chaud.'
        ],
        cookingNotes: ['Ne pas trop cuire pour garder la texture moelleuse.'],
        favoritedByClient: [],
      ),
      RecipeModel(
        id: '2',
        name: 'Salade César',
        description: 'Une salade classique, fraîche et croquante.',
        ingredients: [
          'Laitue romaine',
          'Poulet grillé',
          'Croûtons',
          'Parmesan',
          'Sauce César'
        ],
        imageUrl: 'assets/images/recipe2.png',
        calories: 450,
        category: 'Déjeuner',
        objectif: 'Perte de poids',
        preparationTime: '15-30 minutes',
        createdBy: 'user456',
        createdAt: DateTime.now(),
        protein: 30,
        fat: 25,
        carbohydrates: 15,
        instructions: [
          'Laver et couper la laitue.',
          'Ajouter le poulet grillé et les croûtons.',
          'Parsemer de parmesan.',
          'Assaisonner avec la sauce César.'
        ],
        cookingNotes: ['Utiliser un poulet bio pour une meilleure qualité.'],
        favoritedByClient: [],
      ),
      RecipeModel(
        id: '3',
        name: 'Spaghetti Bolognese',
        description: 'Un plat italien savoureux et réconfortant.',
        ingredients: [
          'Spaghetti',
          'Bœuf haché',
          'Tomates',
          'Oignons',
          'Ail',
          'Basilic'
        ],
        imageUrl: 'assets/images/recipe3.png',
        calories: 700,
        category: 'Diner',
        objectif: 'Prise de masse',
        preparationTime: '30-45 minutes',
        createdBy: 'user789',
        createdAt: DateTime.now(),
        protein: 40,
        fat: 20,
        carbohydrates: 70,
        instructions: [
          'Cuire les spaghetti selon les instructions du paquet.',
          'Faire revenir les oignons et l’ail.',
          'Ajouter le bœuf haché et cuire.',
          'Incorporer les tomates et laisser mijoter.',
          'Servir avec les pâtes et du basilic frais.'
        ],
        cookingNotes: ['Cuire les pâtes al dente pour un meilleur goût.'],
        favoritedByClient: [],
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('Recipes'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.only(right: 14.0, left: 14.0, top: 70.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 70.0,
            childAspectRatio: 0.7,
          ),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return RecipeItem(recipe: recipes[index]);
          },
        ));
  }
}
