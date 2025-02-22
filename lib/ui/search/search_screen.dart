import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:recipe_box/ui/search_results/search_results_view_model.dart';

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
    final searchViewModel = ref.watch(searchViewModelProvider.notifier);
    final SearchParameters searchParameters =
        ref.watch(searchViewModelProvider);

    print('%%%%%%%%%%%%%%%%%%%%%SCREEN REBUIlD%%%%%%%%%%%%%%%%%%%%%%');

    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
        textEditingController: searchController,
        updateQuery: searchViewModel.updateSearchParameters,
        clearDB: ref.watch(searchViewModelProvider.notifier).clearDB,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),

                // Meal Type
                ExpandableChipsCard(
                  chipMode: ChipMode.or,
                  title: 'Meal Type',
                  givenEnums: searchParameters.meals,
                  updateState: searchViewModel.updateSearchParameters,
                ),

                // Cuisines
                ExpandableChipsCard(
                  chipMode: ChipMode.requireExclude,
                  title: 'Cuisines',
                  givenEnums: searchParameters.cuisines,
                  updateState: searchViewModel.updateSearchParameters,
                ),

                // Diets
                ExpandableChipsCard(
                  chipMode: ChipMode.orAnd,
                  title: 'Diets',
                  givenEnums: searchParameters.diets,
                  updateState: searchViewModel.updateSearchParameters,
                ),

                // Equipment
                ExpandableChipsCard(
                  chipMode: ChipMode.or,
                  title: 'Equipment',
                  givenEnums: searchParameters.equipment,
                  updateState: searchViewModel.updateSearchParameters,
                ),

                // Intolerances
                ExpandableChipsCard(
                  chipMode: ChipMode.and,
                  title: 'Intolerances',
                  givenEnums: searchParameters.intolerances,
                  updateState: searchViewModel.updateSearchParameters,
                ),

                // Ingredients
                IngredientsInputCard(
                  removeIngredient: searchViewModel.removeIngredient,
                  updateName: searchViewModel.updateIngredientName,
                  addIngredient: searchViewModel.addIngredient,
                  updateValue: searchViewModel.updateIngredientValue,
                  givenIngredients: searchParameters.ingredients,
                  titleTextStyle: titleTextStyle,
                ),

                // Max Ready Time
                MaxReadyTimeSlider(
                  givenPrimarySliderValue: searchParameters.maxTime,
                  primaryTitle: 'Max Prep & Cook Time',
                  titleTextStyle: titleTextStyle,
                  setValue: searchViewModel.updateSearchParameters,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Servings',
                  givenMaxValue: searchParameters.servings.end,
                  givenMinValue: searchParameters.servings.start,
                  updateState: searchViewModel.updateSearchParameters,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
                  titleTextStyle: titleTextStyle,
                ),

                // Carbs
                MinMaxSliders(
                  title: 'Calories',
                  givenMaxValue: searchParameters.calories.end,
                  givenMinValue: searchParameters.calories.start,
                  updateState: searchViewModel.updateSearchParameters,
                  sliderMaximum: 1000,
                  sliderMinimum: 0,
                  titleTextStyle: titleTextStyle,
                ),

                // Protein
                MinMaxSliders(
                  title: 'Protein',
                  givenMaxValue: searchParameters.protein.end,
                  givenMinValue: searchParameters.protein.start,
                  updateState: searchViewModel.updateSearchParameters,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
                  titleTextStyle: titleTextStyle,
                ),

                // Fat
                MinMaxSliders(
                  title: 'Fat',
                  givenMaxValue: searchParameters.fat.end,
                  givenMinValue: searchParameters.fat.start,
                  updateState: searchViewModel.updateSearchParameters,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
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
  final Function(Map<String, dynamic>) updateQuery;
  final Function clearDB;
  final TextEditingController textEditingController;
  const _FloatingActionButtons({
    required this.updateQuery,
    required this.clearDB,
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
              clearDB(); // removes all the present data on the database
              updateQuery({'query': textEditingController.text});

              // searchForRecipes();

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
