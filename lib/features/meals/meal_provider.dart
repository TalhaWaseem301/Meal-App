// lib/features/meal/data/meal_repository_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/features/meals/presentation/view_model/meal_state.dart';
import 'package:meals_app/features/meals/presentation/view_model/meal_view_model.dart';
import '../../core/network/provider/api_provider.dart';
import 'data/repositries/recipe_repositriy.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MealRepository(apiService: apiService);
});

final mealViewModelProvider =
StateNotifierProvider<MealViewModel, MealState>((ref) {
  final repo = ref.watch(mealRepositoryProvider);
  return MealViewModel(repo);
});


