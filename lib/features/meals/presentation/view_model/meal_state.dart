import '../../data/model/recipe_response.dart';

class MealState {
  final List<Recipes> recipes;
  final List<String> favouriteMealIds;
  final List<String> cuisines;
  final bool isLoading;
  final String? error;
  final String? selectedCuisine;

  MealState({
    this.recipes = const [],
    this.favouriteMealIds=const[],
    this.cuisines = const [],
    this.isLoading = false,
    this.error,
    this.selectedCuisine,
  });

  MealState copyWith({
    List<Recipes>? recipes,
    List<String>? favouriteMealIds,
    List<String>? cuisines,
    bool? isLoading,
    String? error,
    String? selectedCuisine,
  }) {
    return MealState(
      recipes: recipes ?? this.recipes,
      favouriteMealIds: favouriteMealIds ?? this.favouriteMealIds,
      cuisines: cuisines ?? this.cuisines,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedCuisine: selectedCuisine ?? this.selectedCuisine,
    );
  }
}
