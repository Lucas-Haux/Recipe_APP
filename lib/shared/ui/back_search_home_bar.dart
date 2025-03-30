import 'package:flutter/material.dart';
import 'package:recipe_box/shared/ui/recipe_search_bar.dart';

class BackSearchHomeBar extends StatelessWidget {
  final bool backButton;
  const BackSearchHomeBar({required this.backButton, super.key});

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
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
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
          Hero(
            tag: const Key('HomeButton'),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: Icon(
                Icons.home,
                size: 30,
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
