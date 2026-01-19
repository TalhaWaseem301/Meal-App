// lib/features/meal/data/meal_repository.dart
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/dio_client.dart';
import '../model/recipe_response.dart';

import '../../../../core/network/network_exceptions.dart';

class MealRepository {
  final ApiService apiService;

  MealRepository({required this.apiService});

  /// Get recipes from API
  Future<RecipeResponse> getRecipes({int limit = 10}) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.recipes,
        queryParams: {'limit': limit},
      );
      final parsed =RecipeResponse.fromJson(response.data);
      print('🍽 Recipes count: ${parsed.recipes?.length}');
      return parsed ;
    } on NetworkException catch (e) {
      throw e;
    } catch (e) {
      throw Exception("Failed to fetch recipes: $e");
    }
  }
}
