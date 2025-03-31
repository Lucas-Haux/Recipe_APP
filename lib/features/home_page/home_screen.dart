import 'package:flutter/material.dart';
//import 'package:recipe_box/domain/models/recipe_model.dart';
//import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';
//import 'package:recipe_box/ui/home/widgets/favorites_widget.dart';
//import 'package:recipe_box/ui/home/widgets/popular_searchs_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_manager.dart';
import 'package:recipe_box/shared/themes/dimens.dart';
import 'package:recipe_box/shared/ui/recipe_search_bar.dart';
import 'widgets/settings_and_tokens_buttons.dart';
import 'package:recipe_box/features/home_page/widgets/favorites/favorites_card.dart';
import 'package:recipe_box/features/home_page/widgets/popular_searches/popular_searches_card.dart';

//import '../core/ui/search_bar_field_widget.dart';

//TextEditingController searchController = TextEditingController();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(homeManagerProvider.notifier);
    manager.getFavoritesList();

    final favoritesList = ref.watch(homeManagerProvider).value;

    //remove
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.of(context).paddingScreenHorizontal,
          vertical: Dimens.paddingVertical,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60), // Gap on Top

            //  Search Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: 'SearchBar',
                child: RecipeSearchBar(
                  key: const ValueKey('SearchBar'),
                  searchPage: false,
                ),
              ),
            ),
            const Spacer(),

            PopularSearchesCard(height: height),

            Spacer(),

            FavoritesCard(height: height, favoritesList: favoritesList ?? []),

            const Spacer(),
            // Settings and tokens Buttons
            SettingsAndTokensButtons(),
          ],
        ),
      ),
    );
  }
}
