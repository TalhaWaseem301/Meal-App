enum MealType {
  Breakfast,
  Dinner,
  Appetizer,
}

extension MealTypeExtension on MealType {
  String get name {
    switch (this) {
      case MealType.Breakfast:
        return "Breakfast";
      case MealType.Dinner:
        return "Dinner";
      case MealType.Appetizer:
        return "Appetizer";
    }
  }
}
