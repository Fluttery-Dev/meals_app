import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  isGlutenFree,
  isLactoseFree,
  isVegetarian,
  isVegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.isGlutenFree: false,
          Filter.isLactoseFree: false,
          Filter.isVegan: false,
          Filter.isVegetarian: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (filters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (filters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (filters[Filter.isVegan]! && !meal.isVegan) {
      return false;
    }
    if (filters[Filter.isVegetarian]! && !meal.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
