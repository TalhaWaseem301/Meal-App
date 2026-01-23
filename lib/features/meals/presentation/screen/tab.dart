import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/meals_item.dart';
import '../../data/model/meal_type.dart';
import '../../favourite_provider.dart';
import '../../filter_provider.dart';
import '../../meal_provider.dart';
import 'category_screen.dart';
import 'filter_screen.dart';
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
    return Consumer(
      builder: (context, ref, _) {
        // 🔹 Business data (meals)
        final mealState = ref.watch(mealViewModelProvider);

        // 🔹 UI interaction data (favorites)
        final favouriteIds = ref.watch(favouriteProvider);
        final filters = ref.watch(filterProvider);

        // Favorites tab:
        final favouriteMeals = mealState.recipes.where((meal) {
          if (!favouriteIds.contains(meal.id.toString())) return false;
          if (!filters.filters.containsValue(true)) return true;

          if (filters.filters[MealType.Breakfast] == true &&
              meal.mealType == "Breakfast") return true;
          if (filters.filters[MealType.Dinner] == true &&
              meal.mealType == "Dinner") return true;
          if (filters.filters[MealType.Appetizer] == true &&
              meal.mealType == "Appetizer") return true;

          return false;
        }).toList();

        Widget activePage;
        String activePageTitle;

        // ================= TAB 1 : CATEGORIES =================
        if (_selectedPageIndex == 0) {
          activePage = const CategoryScreen();
          activePageTitle = 'Cuisines';
        }

        // ================= TAB 2 : FAVORITES =================
        else {
          final favouriteMeals = mealState.recipes
              .where(
                (meal) => favouriteIds.contains(meal.id.toString()),
          )
              .toList();

          activePage = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favouriteMeals.length,
            itemBuilder: (ctx, index) {
              final meal = favouriteMeals[index];

              return RecipeCard(
                meal: meal,
                onSelectMeal: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(meal: meal),
                    ),
                  );
                },
                onToggleFavorite: () {
                  ref
                      .read(favouriteProvider.notifier)
                      .toggle(meal.id.toString());
                },
                traits: {
                  Icons.schedule: '${meal.prepTimeMinutes ?? 0} min',
                  Icons.work: meal.difficulty ?? 'N/A',
                  Icons.star:
                  '${meal.rating?.toStringAsFixed(1) ?? '0'}',
                },
              );
            },
          );

          activePageTitle = 'Your Favorites';
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(activePageTitle),
          ),
          // ================= drawer =================
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child:  Text(
                        'My Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
                ),
                ListTile(
                  leading: Icon(Icons.set_meal),
                  title: Text("Meals"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Filters"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilterScreen(),
                      ),
                    );

                  },
                ),
              ],
            ),
          ),

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
      },
    );
  }
}
