import '../../data/model/meal_type.dart';

class FilterState {
  final Map<MealType, bool> filters;

  FilterState({required this.filters});

  FilterState copyWith({Map<MealType, bool>? filters}) {
    return FilterState(
      filters: filters ?? this.filters,
    );
  }
}

// initial state
final initialFilterState = FilterState(filters: {
  MealType.Breakfast: false,
  MealType.Dinner: false,
  MealType.Appetizer: false,
});
