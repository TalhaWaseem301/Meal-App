import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/features/meals/data/repositries/recipe_repositriy.dart';
import '../../data/model/recipe_response.dart';
import 'meal_state.dart';

class MealViewModel extends StateNotifier<MealState> {
  final MealRepository repository;

  MealViewModel(this.repository) : super(MealState()) {
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      state = state.copyWith(isLoading: true);

      final response = await repository.getRecipes();
      final recipes = response.recipes ?? [];

      // Extract unique cuisines here
      final cuisines = recipes
          .map((r) => r.cuisine ?? 'Unknown')
          .toSet()
          .toList();

      // Update state with recipes and cuisines
      state = state.copyWith(
        recipes: recipes,
        cuisines: cuisines,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }



  void selectCuisine(String cuisine) {
    state = state.copyWith(selectedCuisine: cuisine);
  }


}
