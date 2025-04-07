import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/detailed_recipe_display_card.dart';

class InfiniteScrollPagination extends StatefulWidget {
  final int? totalResults;
  final Future<List<Recipe>> Function(num, num) getArticleListPage;
  final List<Recipe>? recipes;
  const InfiniteScrollPagination({
    this.recipes,
    required this.getArticleListPage,
    this.totalResults,
    super.key,
  });

  @override
  InfiniteScrollPaginationState createState() =>
      InfiniteScrollPaginationState();
}

class InfiniteScrollPaginationState extends State<InfiniteScrollPagination> {
  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedMasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            itemBuilder: (context, recipe, index) => Hero(
              tag: '${recipe.id}Card',
              child: Material(
                key: ValueKey('${recipe.id}Card'),
                child: DetailedRecipeDisplayCard(
                  recipe: recipe,
                  showPopularBadge: false,
                  recipeListIndex: index,
                ),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => Text('error'),
            noItemsFoundIndicatorBuilder: (context) =>
                Text('No Recipes Found With This Search'),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
        ),
      );

  final _pagingController = PagingController<num, Recipe>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey.toInt());
    });
    super.initState();
  }

  Future<void> _fetchPage(num pageKey) async {
    try {
      print('what');
      final newPage = await widget.getArticleListPage(
        pageKey.toInt(),
        8,
      );

      //final previouslyFetchedItemsCount =
      //    _pagingController.itemList?.length ?? 0;

      bool isLastPage = false;
      int totalRecipeResults =
          (widget.totalResults != null) ? widget.totalResults! : 0;
      if (totalRecipeResults < (pageKey + 1) * 8) {
        print('totalRecipeResults: $totalRecipeResults');
        isLastPage = true;
      } else {
        isLastPage = false;
      }

      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey.toInt());
      }
    } catch (error, stackTrack) {
      // 4
      debugPrint('infinite scroll error $error /n \n $stackTrack');
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }
}
