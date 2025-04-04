import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/detailed_recipe_display_card.dart';

class InfiniteScrollPagination extends StatefulWidget {
  const InfiniteScrollPagination({
    this.recipes,
    required this.getArticleListPage,
    super.key,
  });
  final Future<List<Recipe>> Function(num, num) getArticleListPage;
  final List<Recipe>? recipes;

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
            noItemsFoundIndicatorBuilder: (context) => Text('loading'),
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
      final newPage = await widget.getArticleListPage(
        pageKey.toInt(),
        8,
      );

      final previouslyFetchedItemsCount =
          // 2
          _pagingController.itemList?.length ?? 0;

      //TODO isLastPage
      final isLastPage = false;
      final newItems = newPage;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
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
