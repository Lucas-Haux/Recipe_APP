import 'package:flutter/material.dart';
import 'package:recipe_box/shared/ui/recipe_search_bar.dart';

class BackSearchHomeBar extends StatelessWidget {
  final bool backButton;
  final bool homeButton;
  const BackSearchHomeBar({
    required this.backButton,
    required this.homeButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),

          if (backButton) ...[
            // Back Button
            Hero(
              tag: const Key('BackButton'),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 39,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const Spacer(),
          ],
          // Search Button
          SizedBox(
            height: 45,
            width: backButton ? 250 : 300,
            child: Hero(
              tag: 'SearchBar',
              child: RecipeSearchBar(
                key: const ValueKey('SearchBar'),
                searchPage: false,
              ),
            ),
          ),
          const Spacer(),

          // Home Button
          if (homeButton)
            Hero(
              tag: const Key('HomeButton'),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                icon: Icon(
                  Icons.home_rounded,
                  size: 38,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

          const Spacer(),
        ],
      ),
    );
  }
}
