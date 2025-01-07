import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums.dart';
import 'search_view_model.dart';
import 'widgets/expandable_chips_card_widget.dart';
import 'widgets/slider_card_widgets.dart';
import 'widgets/ingredients_selecter_card_widget.dart';
import '../core/ui/search_bar_field_widget.dart';

TextStyle titleTextStyle = const TextStyle(fontSize: 25);

class SearchScreen extends ConsumerWidget {
  final TextEditingController searchController;
  const SearchScreen({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchViewModel = SearchViewModel(ref);

    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
        textEditingController: searchController,
        updateQuery: searchViewModel.setQuery,
        searchForRecipes: searchViewModel.searchForRecipes,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            pinned: true,
            snap: false,
            expandedHeight: 250.0,
            leading: const SizedBox(), // hide backbutton in bar
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              background: const Center(
                child: Text(
                  'Search For A Recipe!',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  bottom: 8.0,
                ),
                height: 70,

                // Search Field
                child: Hero(
                  tag: 'SearchBar',
                  child: SearchBarFieldWidget(
                    key: const ValueKey('SearchBar'),
                    goToSearchPage: false,
                    controller: searchController,
                    onTap: null,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            key: const Key('SearchParameters'),
            child: Column(
              children: [
                const SizedBox(height: 15),
                // Cuisines
                ExpandableChipsCard(
                  chipMode: ChipMode.requireExclude,
                  title: 'Cuisines',
                  enumValues: CuisineType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.selectedCuisines,
                  givenDeselectedEnums:
                      searchViewModel.searchParameters.deselectedCuisines,
                  updateSelectedEnums: searchViewModel.setSelectedCuisines,
                  updateDeselectedEnums: searchViewModel.setDeselectedCuisines,
                ),
                // Diets
                ExpandableChipsCard(
                  chipMode: ChipMode.orAnd,
                  updateAndOr: searchViewModel.setDietAndOr,
                  defualtAndOr: searchViewModel.searchParameters.dietAndOr,
                  title: 'Diets',
                  enumValues: DietType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.requiredDiets,
                  updateSelectedEnums: searchViewModel.setRequiredDiets,
                ),
                // Intolerances
                ExpandableChipsCard(
                  chipMode: ChipMode.and,
                  title: 'Intolerances',
                  enumValues: IntoleranceType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.intolerances,
                  updateSelectedEnums: searchViewModel.setIntolerance,
                ),
                // Ingredients
                IngredientsInputCard(
                  onChanged: (String test) {
                    // Your implementation here
                  },
                  titleTextStyle: titleTextStyle,
                ),
                // Max Ready Time
                MaxReadyTimeSlider(
                  givenPrimarySliderValue:
                      searchViewModel.searchParameters.maxTime,
                  primaryTitle: 'Max Ready Time',
                  titleTextStyle: titleTextStyle,
                  setValue: searchViewModel.setMaxReadyTime,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Servings',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                  titleTextStyle: titleTextStyle,
                ),

                // Carbs
                MinMaxSliders(
                  title: 'Carbs',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                  titleTextStyle: titleTextStyle,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Protein',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                  titleTextStyle: titleTextStyle,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Fat',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                  titleTextStyle: titleTextStyle,
                ),
                const SizedBox(height: 120),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  final void Function(String) updateQuery;
  final VoidCallback searchForRecipes;
  final TextEditingController textEditingController;
  const _FloatingActionButtons({
    required this.updateQuery,
    required this.searchForRecipes,
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
              FocusManager.instance.primaryFocus?.unfocus(); // remove keyboard
              updateQuery(textEditingController.text);
              context.go('/search_results');
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
