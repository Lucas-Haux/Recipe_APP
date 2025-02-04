import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';

import '../home/home_screen.dart';
import '../../data/model/data_state_status_model.dart';
import '../../../domain/models/recipe_model.dart';
import 'search_results_view_model.dart';
import '../core/ui/search_bar_field_widget.dart';
import 'widgets/recipe_display_card_widget.dart';

import './widgets/test_widget.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeState = ref.watch(searchResultsViewModelProvider);

    print('${recipeState.valueOrNull}');
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(),
        title: _AppBar(),
      ),
      body: PagedArticleListView(
        searchParamaters: ref.watch(searchPramatersRepositoryProvider),
        repository: ref.watch(recipeDataRepositoryProvider),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          // Search Button
          SizedBox(
            height: 45,
            width: 300,
            child: Hero(
              tag: 'SearchBar',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: SearchBarFieldWidget(
                  goToSearchPage: true,
                  controller: searchController,
                ),
              ),
            ),
          ),
          const Spacer(),

          // Home Button
          Hero(
            tag: const Key('HomeButton'),
            child: IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
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

bool _showPopularBadge(List<RecipeModel> recipeData) {
  int numberOfPopular = 0;
  for (var recipe in recipeData) {
    if (recipe.popular == true) {
      numberOfPopular++;
    }
  }
  print('total number of popular: $numberOfPopular');
  if (numberOfPopular < 17) {
    return true;
  } else {
    return false;
  }
}
