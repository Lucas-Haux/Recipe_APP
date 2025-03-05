import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';
import 'home_viewmodel.dart';
import '../core/ui/search_bar_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO should these be in viewmodel?
TextEditingController searchController = TextEditingController();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesList = ref.watch(homeViewModelProvider).value;
    final double height = MediaQuery.sizeOf(context).height;
    CarouselController carouselController =
        CarouselController(initialItem: (favoritesList?.length ?? 2) ~/ 2);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gap on Top
            const SizedBox(height: 60),
            // Search Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: 'SearchBar',
                child: SearchBarFieldWidget(
                  key: const ValueKey('SearchBar'),
                  searchPage: false,
                  controller: searchController,
                ),
              ),
            ),
            const Spacer(),
            Divider(),
            if (favoritesList != null)
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: height / 4.5),
                child: CarouselView.weighted(
                  controller: carouselController,
                  shrinkExtent: 500,
                  itemSnapping: true,
                  flexWeights: const <int>[2, 3, 2],
                  children: favoritesList.map((RecipeModel recipe) {
                    return RecipeDisplayCardWidget(
                      title: recipe.title,
                      imageUrl: recipe.imageUrl,
                      recipeId: recipe.recipeId,
                      cardWidth: 350,
                    );
                  }).toList(),
                ),
              ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
