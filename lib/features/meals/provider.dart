import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/model/recipe_response.dart';
import 'meal_provider.dart';

final recipesProvider = FutureProvider<List<Recipes>>((ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final response = await repo.getRecipes();
  return response.recipes ?? [];
});