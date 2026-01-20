import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/grid.dart';

import '../../meal_provider.dart';


class MealScreen extends ConsumerWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealViewModelProvider);
    final viewModel = ref.read(mealViewModelProvider.notifier);

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Scaffold(
        body: Center(child: Text(state.error!)),
      );
    }

    final cuisines = state.cuisines;

    return Scaffold(
      appBar: AppBar(title: const Text("Cuisines")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: cuisines.length,
        itemBuilder: (ctx, index) {
          final cuisine = cuisines[index];
          return CuisineGridItem(
            cuisine: cuisine,
            onTap: () {
             // viewModel.selectCuisine(cuisine);
            },
          );
        },
      ),
    );
  }
}

