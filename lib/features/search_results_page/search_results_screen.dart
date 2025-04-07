import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box/features/search_results_page/search_results_manager.dart';
import 'package:recipe_box/features/search_results_page/widgets/infinite_scroll_pagination.dart';
import 'package:recipe_box/shared/ui/back_search_home_bar.dart';

TextEditingController searchController = TextEditingController();

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(searchResultsManagerProvider.notifier);
    final recipeState = ref.watch(searchResultsManagerProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(),
        title: BackSearchHomeBar(backButton: false, homeButton: true),
        bottomOpacity: 0.7,
        // total results and tokens display
        bottom: recipeState.hasValue
            ? PreferredSize(
                preferredSize: Size(10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Results: ${recipeState.value?.totalResults.toString()}",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    Text(
                      "Used Tokens: ${recipeState.value?.usedTokens.round().toString()}",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ],
                ),
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: InfiniteScrollPagination(
        getArticleListPage: manager.getArticleListPage,
        totalResults: recipeState.value?.totalResults,
      ),
    );
  }
}
