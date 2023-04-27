import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  ConsumerState<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteMealProvider.notifier).isFavorite;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ref
                    .read(favoriteMealProvider.notifier)
                    .toggleFavoriteStatus(widget.meal);
                _showInfoMessage(!isFavorite(widget.meal)
                    ? '${widget.meal.title} removed from favorites'
                    : '${widget.meal.title} added to favorites');
              });
            },
            icon: Icon(
              isFavorite(widget.meal) ? Icons.favorite : Icons.favorite_outline,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              'Ingridients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            for (final ingridient in widget.meal.ingredients)
              Text(
                ingridient,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            const SizedBox(height: 10),
            Text(
              'Cooking Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            for (final step in widget.meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
