import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../domain/enums.dart';
import 'search_view_model.dart';
import 'widgets/expandable_chips_card_widget.dart';
import 'widgets/slider_card_widgets.dart';
import 'widgets/ingredients_selecter_card_widget.dart';
import '../core/ui/search_bar_field_widget.dart';

TextStyle titleTextStyle =
    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

class SearchScreen extends ConsumerWidget {
  const SearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchViewModel = ref.watch(searchViewModelProvider.notifier);
    final SearchParameters searchParameters =
        ref.watch(searchViewModelProvider);

    TextEditingController searchController =
        TextEditingController(text: searchParameters.query);

    bool isModified() {
      final defaultParams = SearchParameters();

      final values = {
        ...searchParameters.meals.values,
        ...searchParameters.equipment.values,
        ...searchParameters.diets.values,
        ...searchParameters.intolerances.values,
        ...searchParameters.cuisines.values,
      };

      // check number ranges
      if (searchParameters.maxTime != defaultParams.maxTime ||
          searchParameters.protein != defaultParams.protein ||
          searchParameters.servings != defaultParams.servings ||
          searchParameters.fat != defaultParams.fat) {
        print('cringe');
        return true;
      }

      // check requireExclude and AndOrType types
      if (values.contains(RequireExclude.require) ||
          values.contains(RequireExclude.exclude) ||
          values.contains(AndOrType.and) ||
          values.contains(AndOrType.or)) {
        return true;
      }

      if (searchParameters.ingredients.isNotEmpty) {
        if (searchParameters.ingredients.keys.length > 1) {
          return true;
        }
        if (searchParameters.ingredients.keys.first.isNotEmpty) {
          return true;
        }
      }

      return false;
    }

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
              background: Center(
                child: TextAnimator(
                  'Search For A Recipe',
                  incomingEffect:
                      WidgetTransitionEffects.incomingOffsetThenScale(
                          duration: const Duration(milliseconds: 600)),
                  outgoingEffect:
                      WidgetTransitionEffects.outgoingOffsetThenScale(
                          duration: const Duration(milliseconds: 600)),
                  atRestEffect: WidgetRestingEffects.none(),
                  textAlign: TextAlign.center,
                  initialDelay: const Duration(milliseconds: 50),
                  spaceDelay: const Duration(milliseconds: 65),
                  characterDelay: const Duration(milliseconds: 65),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                          blurRadius: 9,
                          color: Colors.white.withAlpha(70),
                          offset: Offset(-3, -3)),
                      Shadow(
                          blurRadius: 9,
                          color: Colors.white.withAlpha(70),
                          offset: Offset(3, -3)),
                      Shadow(
                          blurRadius: 9,
                          color: Colors.white.withAlpha(70),
                          offset: Offset(-3, 3)),
                      Shadow(
                          blurRadius: 9,
                          color: Colors.white.withAlpha(70),
                          offset: Offset(3, 3)),
                    ],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                ),
                height: 70,

                // Search Field
                child: Hero(
                  tag: 'SearchBar',
                  child: SearchBarFieldWidget(
                    key: const ValueKey('SearchBar'),
                    searchPage: true,
                    controller: searchController,
                    updateQuery: searchViewModel.updateSearchParameters,
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
                // clear filters bar

                WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromTop(
                          duration: Duration(milliseconds: 100)),
                  outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(
                      duration: Duration(milliseconds: 500)),
                  child: isModified()
                      ? Container(
                          width: 175,
                          padding: EdgeInsets.only(bottom: 3),
                          decoration: ShapeDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                strokeAlign: 2,
                                width: 2,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20)),
                            ),
                          ),
                          child: Text('Clear Filters',
                              textAlign: TextAlign.center),
                        )
                      : null,
                ),

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
                  isModified: () =>
                      searchParameters.maxTime != SearchParameters().maxTime,
                  setValue: searchViewModel.updateSearchParameters,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Servings',
                  givenMaxValue: searchParameters.servings.end,
                  givenMinValue: searchParameters.servings.start,
                  updateState: searchViewModel.updateSearchParameters,
                  isModified: () =>
                      searchParameters.servings != SearchParameters().servings,
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
                  isModified: () =>
                      searchParameters.calories != SearchParameters().calories,
                  sliderMaximum: 2000,
                  sliderMinimum: 0,
                  titleTextStyle: titleTextStyle,
                ),

                // Protein
                MinMaxSliders(
                  title: 'Protein',
                  givenMaxValue: searchParameters.protein.end,
                  givenMinValue: searchParameters.protein.start,
                  updateState: searchViewModel.updateSearchParameters,
                  isModified: () =>
                      searchParameters.protein != SearchParameters().protein,
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
                  isModified: () =>
                      searchParameters.fat != SearchParameters().fat,
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
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
          //Search
          FloatingActionButton.extended(
            heroTag: 'SearchButton',
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus(); // remove keyboard
              await clearDB(); // removes all the present data on the database
              updateQuery({'query': textEditingController.text});

              // searchForRecipes();

              Navigator.pushNamed(context, '/searchPage/searchResults');
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
