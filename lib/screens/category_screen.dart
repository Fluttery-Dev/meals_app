import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/grid_category_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key, required this.filters}) : super(key: key);
  final Map<Filter, bool> filters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(filteredMealsProvider);

    void onSelectCategory(BuildContext context, Category category) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return MealsScreen(
              meals: meals
                  .where((meal) => meal.categories.contains(category.id))
                  .toList(),
              title: '${category.title} Meals',
            );
          },
        ),
      );
    }

    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: availableCategories
            .map(
              (category) => GridCategoryWidget(
                category: category,
                onSelectCategory: () {
                  onSelectCategory(context, category);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
