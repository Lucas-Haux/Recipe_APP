import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import './recipe_display_card_widget.dart';

class RecipeListInfiniteScrollPagination extends StatefulWidget {
  const RecipeListInfiniteScrollPagination({
    this.recipes,
    required this.getArticleListPage,
    super.key,
  });
  final Future<List<RecipeModel>> Function(int, int) getArticleListPage;
  final List<RecipeModel>? recipes;

  @override
  _RecipeListInfiniteScrollPaginationState createState() =>
      _RecipeListInfiniteScrollPaginationState();
}

class _RecipeListInfiniteScrollPaginationState
    extends State<RecipeListInfiniteScrollPagination> {
  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedGridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisExtent: 375,
              mainAxisSpacing: 18,
              childAspectRatio: 1),
          builderDelegate: PagedChildBuilderDelegate<RecipeModel>(
            itemBuilder: (context, recipe, index) => RecipeDisplayCard(
              recipe: recipe,
              showPopularBadge: false,
              recipeListIndex: index,
            ),
            firstPageErrorIndicatorBuilder: (context) => Text('error'),
            noItemsFoundIndicatorBuilder: (context) => Text('loading'),
          ),
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
        ),
      );

  final _pagingController = PagingController<int, RecipeModel>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print('fetching new page');
      final newPage = await widget.getArticleListPage(
        pageKey,
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
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // 4
      print('infinite scroll error $error');
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
