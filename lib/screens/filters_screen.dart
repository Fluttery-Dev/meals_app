import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your filter'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.isGlutenFree]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.isGlutenFree, value),
            title: Text(
              'Gluten Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only Include Gluten Free Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filter.isLactoseFree]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.isLactoseFree, value),
            title: Text(
              'Lactose Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only Include Lactose Free Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filter.isVegetarian]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.isVegetarian, value),
            title: Text(
              'Only Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only Include Vegetarian Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filter.isVegan]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.isVegan, value),
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only Include Vegan Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}
