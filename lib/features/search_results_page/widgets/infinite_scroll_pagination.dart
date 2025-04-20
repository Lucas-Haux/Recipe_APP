import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_box/features/search_results_page/widgets/builder_delegates.dart';
import 'package:recipe_box/shared/models/recipe.dart';

class InfiniteScrollPagination extends StatefulWidget {
  final int? totalResults;
  final Future<List<Recipe>> Function(num, num) getArticleListPage;
  final Function resetUsedTokens;
  final bool isFiltersModified;
  const InfiniteScrollPagination({
    required this.getArticleListPage,
    required this.resetUsedTokens,
    this.totalResults,
    required this.isFiltersModified,
    super.key,
  });

  @override
  InfiniteScrollPaginationState createState() =>
      InfiniteScrollPaginationState();
}

class InfiniteScrollPaginationState extends State<InfiniteScrollPagination> {
  bool isLastPage = false;

  final _pagingController = PagingController<num, Recipe>(
    firstPageKey: 0,
  );

  Future<void> _fetchPage(num pageKey) async {
    try {
      final newPage = await widget.getArticleListPage(
        pageKey.toInt(),
        8,
      );

      int totalRecipeResults =
          (widget.totalResults != null) ? widget.totalResults! : 100;
      if (totalRecipeResults < (pageKey + 1) * 8) {
        setState(() {
          isLastPage = true;
        });
      } else {
        setState(() {
          isLastPage = false;
        });
      }

      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey.toInt());
      }
    } catch (error, stackTrack) {
      debugPrint('infinite scroll error $error /n \n $stackTrack');
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async {
          widget.resetUsedTokens();
          Future.sync(
            () => _pagingController.refresh(),
          );
        },
        child: PagedMasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            animateTransitions: true,
            transitionDuration: Duration(milliseconds: 600),

            // When we get a valid response of Recipes
            itemBuilder: (context, recipe, index) =>
                ItemBuilder(recipe: recipe, index: index),

            // When we get a valid response but no recipes were returned
            noItemsFoundIndicatorBuilder: (context) => NoItemsFoundIndicator(
                isFiltersModified: widget.isFiltersModified),

            // Loading
            firstPageProgressIndicatorBuilder: (context) =>
                FirstPageLoadingIndicator(),

            // Error
            firstPageErrorIndicatorBuilder: (context) =>
                FirstPageErrorIndicator(
                    retry: _pagingController.retryLastFailedRequest),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
        ),
      );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey.toInt());
    });
    super.initState();
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }
}
