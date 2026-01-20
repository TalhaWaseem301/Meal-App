

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/features/meals/data/model/recipe_response.dart';

import '../../meal_provider.dart';

class MealDetailScreen extends ConsumerWidget{
  final Recipes meal;
  const MealDetailScreen({super.key,required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name.toString())),
      body: Text(meal.instructions.toString()),
    );
  }
}