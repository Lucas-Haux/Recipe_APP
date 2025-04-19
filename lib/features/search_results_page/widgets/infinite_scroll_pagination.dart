import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/detailed_recipe_display_card.dart';

class InfiniteScrollPagination extends StatefulWidget {
  final int? totalResults;
  final Future<List<Recipe>> Function(num, num) getArticleListPage;
  final Function resetUsedTokens;
  const InfiniteScrollPagination({
    required this.getArticleListPage,
    required this.resetUsedTokens,
    this.totalResults,
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
