import 'package:flutter/material.dart';
import '../../search_results/widgets/search_results_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_box/ui/home/widgets/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/search_view_model.dart';
import '../../core/ui/search_bar_field_widget.dart';

class SearchScreen extends ConsumerWidget {
  final TextEditingController searchController;
  const SearchScreen({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchViewModelProvider);

    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
          textEditingController: searchController,
          updateQuery:
              ref.read(searchViewModelProvider.notifier).updateSearchQuery),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            pinned: true,
            snap: false,
            expandedHeight: 180.0,
            leading: const SizedBox(), // hide backbutton in bar
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              background: const Center(
                child: Text(
                  'Search For A Recipe!',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 8.0),
                height: 70,

                // Search Field
                child: Hero(
                  tag: 'SearchBar',
                  child: SearchBarFieldWidget(
                    key: const ValueKey('homePageSearch'),
                    goToSearchPage: false,
                    controller: searchController,
                    autofocus: true,
                    onTap: null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  final void Function(String) updateQuery;
  final TextEditingController textEditingController;
  const _FloatingActionButtons({
    required this.updateQuery,
    required this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          // Home
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 63.0),
            child: FloatingActionButton.small(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.home),
              onPressed: () {
                print('go home');
                context.go('/');
              },
            ),
          ),
          //Search
          FloatingActionButton.extended(
            heroTag: 'SearchButton',
            onPressed: () {
              updateQuery(textEditingController.text);
              // SearchViewModel().searchForRecipes(searchController.text.trim());
              context.go('/search_results');

              // Removes keyboard after switch
              FocusManager.instance.primaryFocus?.unfocus();
            },
            icon: const Icon(Icons.search),
            extendedPadding: const EdgeInsets.only(left: 15, right: 15),
            label: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
