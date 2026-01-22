// lib/features/meals/presentation/view_model/filter_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/features/meals/presentation/view_model/filter_state.dart';

import 'data/model/meal_type.dart';


class FilterViewModel extends StateNotifier<FilterState> {
  FilterViewModel() : super(initialFilterState);

  void toggle(MealType type) {
    final newFilters = Map<MealType, bool>.from(state.filters);
    newFilters[type] = !(newFilters[type] ?? false);
    state = state.copyWith(filters: newFilters);
  }

  void setFilter(MealType type, bool value) {
    final newFilters = Map<MealType, bool>.from(state.filters);
    newFilters[type] = value;
    state = state.copyWith(filters: newFilters);
  }
}

// PROVIDER
final filterProvider =
StateNotifierProvider<FilterViewModel, FilterState>((ref) {
  return FilterViewModel();
});
