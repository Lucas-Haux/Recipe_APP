import 'package:flutter/material.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/detailed_recipe_display_card.dart';

class ItemBuilder extends StatelessWidget {
  final int index;
  final Recipe recipe;
  const ItemBuilder({required this.recipe, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Hero(
        tag: '${recipe.id}Card',
        child: DetailedRecipeDisplayCard(
          recipe: recipe,
          showPopularBadge: false,
          recipeListIndex: index,
        ),
      ),
    );
  }
}

class FirstPageLoadingIndicator extends StatelessWidget {
  const FirstPageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 3.5,
        child: CircularProgressIndicator(strokeCap: StrokeCap.round),
      ),
    );
  }
}

class NoItemsFoundIndicator extends StatelessWidget {
  final bool isFiltersModified;
  const NoItemsFoundIndicator({required this.isFiltersModified, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Text(
          'No Recipes Found With This Search :/',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 30),
        ),
        if (isFiltersModified)
          Text(
            "Our filters help you narrow down your recipe search, but sometimes recipes aren't labeled perfectly. Try removing one or more filters. This will show you a wider range of recipes, including those that might have been miscategorized.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
      ],
    );
  }
}

class FirstPageErrorIndicator extends StatelessWidget {
  final Function() retry;
  const FirstPageErrorIndicator({required this.retry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Something Went Wrong :/',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'The application has encountered an unknown error.\nPlease try again later.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () => retry(),
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondaryContainer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
