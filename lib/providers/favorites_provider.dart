import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool isFavorite(Meal meal) => state.contains(meal);

  void toggleFavoriteStatus(Meal meal) {
    if (isFavorite(meal)) {
      state = state.where((element) => element.id != meal.id).toList();
    } else {
      state = state + [meal];
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
