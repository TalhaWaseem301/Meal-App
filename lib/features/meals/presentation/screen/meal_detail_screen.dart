import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/recipe_response.dart';

class MealDetailScreen extends ConsumerWidget {
  final Recipes meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name ?? 'Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image
            if (meal.image != null && meal.image!.isNotEmpty)
              Image.network(
                meal.image!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 250,
                  color: Colors.grey,
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),

            const SizedBox(height: 16),

            // Ingredients Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (meal.ingredients ?? []).map((ingredient) {
                  return Text(
                    '• $ingredient',
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Instructions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                (meal.instructions ?? []).asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '${entry.key + 1}. ${entry.value}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
