import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../filter_provider.dart';
import '../../data/model/meal_type.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: ListView(
        children: MealType.values.map((mealType) {
          return SwitchListTile(
            title: Text(mealType.name),
            value: filterState.filters[mealType] ?? false,
            onChanged: (value) {
              ref.read(filterProvider.notifier).setFilter(mealType, value);
            },
          );
        }).toList(),
      ),
    );
  }
}
