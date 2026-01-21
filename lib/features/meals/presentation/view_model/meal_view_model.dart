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

  List<Recipes> get filteredRecipes {
    if (state.selectedCuisine == null) return state.recipes;
    return state.recipes
        .where((r) => r.cuisine == state.selectedCuisine)
        .toList();
  }


 void toggleFavorite(String mealId){
    final isfavourite= state.favouriteMealIds.contains(mealId);

    if(isfavourite)
      {
        final updateList= state.favouriteMealIds.where((id)=> id!=mealId).toList();
        state=state.copyWith(favouriteMealIds: updateList);
      }
    else{
      final updatedList = [...state.favouriteMealIds, mealId];
      state = state.copyWith(favouriteMealIds: updatedList);
    }
  }



}
