import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../features/meals/data/model/recipe_response.dart';


/// Small reusable trait widget
class MealItemTrait extends StatelessWidget {
  final IconData icon;
  final String label;

  const MealItemTrait({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

/// Flexible Recipe/Meal Card
class RecipeCard extends StatelessWidget {
  final Recipes meal;
  final VoidCallback onSelectMeal;

  /// A map of trait label + icon you want to display
  final Map<IconData, String> traits;

  const RecipeCard({
    super.key,
    required this.meal,
    required this.onSelectMeal,
    this.traits = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: onSelectMeal,
        child: Stack(
          children: [
            // Image
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.image ?? ''),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              imageErrorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey, height: 200),
            ),

            // Gradient overlay + info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      meal.name ?? 'Unknown',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Traits row
                    if (traits.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: traits.entries
                            .map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6),
                          child: MealItemTrait(
                            icon: entry.key,
                            label: entry.value,
                          ),
                        ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
