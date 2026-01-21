import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/meals_item.dart';
import '../../meal_provider.dart';

import 'category_screen.dart';
import 'meal_detail_screen.dart';


class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(mealViewModelProvider);
      final viewModel = ref.read(mealViewModelProvider.notifier);

      Widget activePage;
      String activePageTitle;

      if (_selectedPageIndex == 0) {
        // Categories tab
        activePage = const CategoryScreen();
        activePageTitle = 'Cuisines';
      } else {
        // Favorites tab → filter meals by favoriteMealIds
        final favoriteMeals = state.recipes
            .where((meal) => state.favouriteMealIds.contains(meal.id.toString()))
            .toList();

        // Show the filtered favorite meals
        activePage = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favoriteMeals.length,
          itemBuilder: (ctx, index) {
            final meal = favoriteMeals[index];

            return RecipeCard(
              meal: meal,
              onSelectMeal: () {
                // Navigate to MealDetailScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailScreen(meal: meal),
                  ),
                );
              },
              onToggleFavorite: () {
                // Toggle favorite
                viewModel.toggleFavorite(meal.id.toString());
              },
              traits: {
                Icons.schedule: '${meal.prepTimeMinutes ?? 0} min',
                Icons.work: meal.difficulty ?? 'N/A',
                Icons.star: '${meal.rating?.toStringAsFixed(1) ?? '0'}',
              },
            );
          },
        );

        activePageTitle = 'Your Favorites';
      }

      return Scaffold(
        appBar: AppBar(title: Text(activePageTitle)),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
      );
    });
  }
}
