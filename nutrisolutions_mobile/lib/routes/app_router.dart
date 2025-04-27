import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers/drawer_provider.dart';
import '../features/auth/login/login_screen.dart';
import '../features/auth/reset pass/reset_pass_screen.dart';
import '../features/auth/signup/signup_screen.dart';
import '../features/home/home_screen.dart';
import '../features/nutritionistes/nutritionists_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/recipes/recipe_details_screen.dart';
import '../features/recipes/recipes_screen.dart';
import '../shared/custom_drawer.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/recipes',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Consumer(
          builder: (context, ref, _) {
            return Scaffold(
              drawer: CustomDrawer(),
              onDrawerChanged: (isOpened) {
                ref.read(drawerStateProvider.notifier).state = isOpened;
              },
              appBar: AppBar(
                title: Text(
                  "NUTRISOLUTIONS",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              body: child,
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
            path: '/reset-password',
            builder: (context, state) {
              final token = state.uri.queryParameters['token'] ?? '';
              return ResetPasswordScreen(token: token);
            }),
        GoRoute(
          path: '/recipes',
          builder: (context, state) => const RecipesScreen(),
        ),
        GoRoute(
            path: '/recipes/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return RecipeDetailsScreen(recipeId: id);
            }),
        GoRoute(
          path: '/nutritionists',
          builder: (context, state) => NutritionistsScreen(),
        ),
        GoRoute(
          path: '/profile/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProfileScreen(userId: id);
          },
        ),
      ],
    ),
  ],
);
