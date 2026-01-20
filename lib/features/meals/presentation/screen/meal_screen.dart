import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/meals_item.dart';
import '../../meal_provider.dart';
import 'meal_detail_screen.dart';

class MealScreen extends ConsumerWidget {
  final String cuisine;
  const MealScreen({super.key, required this.cuisine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mealViewModelProvider.notifier);
    final recipes = viewModel.filteredRecipes;

    return Scaffold(
      appBar: AppBar(title: Text("$cuisine Recipes")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (ctx, index) {
          final recipe = recipes[index];
          return RecipeCard(
            meal: recipe,
            onSelectMeal: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealDetailScreen(meal: recipe),
                ),
              );

            },
            traits: {
              Icons.schedule: '${recipe.prepTimeMinutes ?? 0} min',
              Icons.work: recipe.difficulty ?? 'N/A',
              Icons.star: '${recipe.rating?.toStringAsFixed(1) ?? '0'}',
              // You can add more dynamically if needed
            },
          );
        },
      ),
    );
  }
}
