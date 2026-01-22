import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FavouriteViewModel extends StateNotifier<Set<String>> {
  FavouriteViewModel() : super({});

  void toggle(String mealId) {
    if (state.contains(mealId)) {
      state = {...state}..remove(mealId);
    } else {
      state = {...state, mealId};
    }
  }

  bool isFavourite(String mealId) {
    return state.contains(mealId);
  }
}


final favouriteProvider=StateNotifierProvider<FavouriteViewModel,Set<String>>((ref){
  return FavouriteViewModel();
});
