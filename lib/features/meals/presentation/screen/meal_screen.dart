import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/meals_item.dart';
import '../../meal_provider.dart';
import '../../filter_provider.dart';
import '../../data/model/meal_type.dart';
import 'meal_detail_screen.dart';

class MealScreen extends ConsumerWidget {
  final String cuisine;

  const MealScreen({super.key, required this.cuisine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealState = ref.watch(mealViewModelProvider);
    final filters = ref.watch(filterProvider);

    final recipes = mealState.recipes.where((meal) {
      // 1️⃣ Filter by selected cuisine
      if (meal.cuisine != cuisine) return false;

      // 2️⃣ If no filters are selected → show all meals of this cuisine
      if (!filters.filters.containsValue(true)) return true;

      // 3️⃣ Check meal types (meal.mealType is List<String>)
      final mealTypes = (meal.mealType ?? []).map((e) => e.toLowerCase()).toList();

      if (filters.filters[MealType.Breakfast] == true &&
          mealTypes.contains("breakfast")) return true;

      if (filters.filters[MealType.Dinner] == true &&
          mealTypes.contains("dinner")) return true;

      if (filters.filters[MealType.Appetizer] == true &&
          mealTypes.contains("appetizer")) return true;
     // print(mealTypes);
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("$cuisine Recipes")),
      body: recipes.isEmpty
          ? Center(
        child: Text(
          "No meals available for selected filters!",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      )
          : ListView.builder(
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
            onToggleFavorite: () {},
            traits: {
              Icons.schedule: '${recipe.prepTimeMinutes ?? 0} min',
              Icons.work: recipe.difficulty ?? 'N/A',
              Icons.star: '${recipe.rating?.toStringAsFixed(1) ?? '0'}',
            },
          );
        },
      ),
    );
  }
}

