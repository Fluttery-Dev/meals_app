import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/grid_category_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
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

    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.decelerate),
        ),
        child: child,
      ),
    );
  }
}
