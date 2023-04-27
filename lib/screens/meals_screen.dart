import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });
  final List<Meal> meals;
  final String? title;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget _noMeals = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Umm ... Nothing to show here',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 10),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
    final Widget content = meals.isEmpty
        ? _noMeals
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return MealItem(
                meal: meals[index],
                onSelectMeal: () {
                  onSelectMeal(context, meals[index]);
                },
              );
            },
          );
    return title == null
        ? content
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content,
          );
  }
}
