import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import './recipe_display_card_widget.dart';

class PagedArticleListView extends StatefulWidget {
  const PagedArticleListView({
    required this.repository,
    required this.searchParamaters,
    this.recipes,
    super.key,
  })  : assert(repository != null),
        assert(searchParamaters != null);

  final RecipeDataRepository repository;
  final SearchParameters searchParamaters;
  final List<RecipeModel>? recipes;

  @override
  _PagedArticleListViewState createState() => _PagedArticleListViewState();
}

class _PagedArticleListViewState extends State<PagedArticleListView> {
  List<RecipeModel>? get _recipes => widget.recipes;

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
      final newPage = await widget.repository.getArticleListPage(
        pageKey,
        8,
        widget.searchParamaters,
      );

      final previouslyFetchedItemsCount =
          // 2
          _pagingController.itemList?.length ?? 0;

      final isLastPage = false;
      final newItems = newPage;

      if (isLastPage) {
        // 3
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // 4
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
