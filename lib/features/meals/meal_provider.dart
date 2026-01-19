// lib/features/meal/data/meal_repository_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/provider/api_provider.dart';
import 'data/repositries/recipe_repositriy.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider); // Get ApiService instance
  return MealRepository(apiService: apiService);
});

