import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/recipe_model.dart';
import 'search_results_view_model.dart';
import '../core/ui/search_bar_field_widget.dart';

import './widgets/recipe_list_infinite_scroll_pagination_widget.dart';

TextEditingController searchController = TextEditingController();

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(searchResultsViewModelProvider.notifier);
    final recipeState = ref.watch(searchResultsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(),
        title: _AppBar(),
        bottom: recipeState.hasValue
            ? PreferredSize(
                preferredSize: Size(10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Total Results: ${recipeState.value?.totalResults.toString()}"),
                    Text(
                        "Used Tokens: ${recipeState.value?.usedTokens.round().toString()}"),
                  ],
                ),
              )
            : null,
        bottomOpacity: 0.7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: RecipeListInfiniteScrollPagination(
        getArticleListPage: viewModel.getArticleListPage,
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
              child: SearchBarFieldWidget(
                key: const ValueKey('SearchBar'),
                searchPage: false,
                controller: searchController,
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
