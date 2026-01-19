import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/grid.dart';
import '../../data/model/recipe_response.dart';
import '../../provider.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipesProvider);

        return Scaffold(
          appBar: AppBar(title: const Text("Cuisines")),
          body: recipesAsync.when(
            data: (recipes) {
              // Extract unique cuisines
              final cuisines = recipes
                  .map((r) => r.cuisine ?? 'Unknown') // fallback if null
                  .toSet()
                  .toList();

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2, // adjust as needed
                ),
                itemCount: cuisines.length,
                itemBuilder: (ctx, index) {
                  final cuisine = cuisines[index];
                  return CuisineGridItem(
                    cuisine: cuisine,
                    onTap: () {
                      // Handle tap if you want to filter recipes
                      print("Tapped on cuisine: $cuisine");
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text("Error: $err")),
          ),
        );
  }
}
