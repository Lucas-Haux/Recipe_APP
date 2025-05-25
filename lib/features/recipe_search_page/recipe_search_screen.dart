import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/expandable_chips.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/filters_warning.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/floating_action_buttons.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/ingreidents_input.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/recipe_search_app_bar.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/slider_card.dart';

import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/sort_options.dart';

import 'package:recipe_box/features/recipe_search_page/recipe_search_manager.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

TextStyle titleTextStyle =
    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

class RecipeSearchScreen extends ConsumerStatefulWidget {
  const RecipeSearchScreen({
    super.key,
  });
  @override
  ConsumerState<RecipeSearchScreen> createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends ConsumerState<RecipeSearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipeSearchManagerProvider.notifier).refreshFromDatabase();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(recipeSearchManagerProvider.notifier);
    final SearchParameters searchParameters =
        ref.watch(recipeSearchManagerProvider);

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
      floatingActionButton: FloatingActionButtons(
        textEditingController: searchController,
        updateQuery: manager.updateSearchParameters,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          RecipeSearchAppBar(
            isModified: isModified(),
            searchController: searchController,
            updateSearchParameters: manager.updateSearchParameters,
            clearSearchParameters: manager.clearSearchParameters,
            matchTitle: searchParameters.matchTitle,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),

                // Sorting Chips
                SortOptions(
                  currentSorting: searchParameters.sorting,
                  updateState: manager.updateSearchParameters,
                ),

                // Fillters Warning
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                  outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
                  child: isModified() ? FiltersWarning() : null,
                ),

                //Meal Type
                ExpandableChipsCard(
                  chipMode: ChipMode.or,
                  title: 'Meal Type',
                  givenEnums: searchParameters.meals,
                  updateState: manager.updateSearchParameters,
                ),
                //
                // Cuisines
                ExpandableChipsCard(
                  chipMode: ChipMode.requireExclude,
                  title: 'Cuisines',
                  givenEnums: searchParameters.cuisines,
                  updateState: manager.updateSearchParameters,
                ),

                // Diets
                ExpandableChipsCard(
                  chipMode: ChipMode.orAnd,
                  title: 'Diets',
                  givenEnums: searchParameters.diets,
                  updateState: manager.updateSearchParameters,
                ),

                // Equipment
                ExpandableChipsCard(
                  chipMode: ChipMode.or,
                  title: 'Equipment',
                  givenEnums: searchParameters.equipment,
                  updateState: manager.updateSearchParameters,
                  searchBar: true,
                ),

                // Intolerances
                ExpandableChipsCard(
                  chipMode: ChipMode.and,
                  title: 'Intolerances',
                  givenEnums: searchParameters.intolerances,
                  updateState: manager.updateSearchParameters,
                ),
                //
                // Ingredients
                IngredientsInput(
                  removeIngredient: manager.removeIngredient,
                  updateName: manager.updateIngredientName,
                  addIngredient: manager.addIngredient,
                  updateValue: manager.updateIngredientValue,
                  givenIngredients: searchParameters.ingredients,
                ),

                // Max Ready Time
                MaxReadyTimeSlider(
                  givenPrimarySliderValue: searchParameters.maxTime,
                  primaryTitle: 'Max Prep & Cook Time',
                  isModified: () =>
                      searchParameters.maxTime != SearchParameters().maxTime,
                  setValue: manager.updateSearchParameters,
                ),

                // Servings
                MinMaxSliders(
                  title: 'Servings',
                  range: searchParameters.servings,
                  updateState: manager.updateSearchParameters,
                  isModified: () =>
                      searchParameters.servings != SearchParameters().servings,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
                ),

                // Carbs
                MinMaxSliders(
                  title: 'Calories',
                  range: searchParameters.calories,
                  updateState: manager.updateSearchParameters,
                  isModified: () =>
                      searchParameters.calories != SearchParameters().calories,
                  sliderMaximum: 2000,
                  sliderMinimum: 0,
                ),

                // Protein
                MinMaxSliders(
                  title: 'Protein',
                  range: searchParameters.protein,
                  updateState: manager.updateSearchParameters,
                  isModified: () =>
                      searchParameters.protein != SearchParameters().protein,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
                ),

                // Fat
                MinMaxSliders(
                  title: 'Fat',
                  range: searchParameters.fat,
                  updateState: manager.updateSearchParameters,
                  isModified: () =>
                      searchParameters.fat != SearchParameters().fat,
                  sliderMaximum: 100,
                  sliderMinimum: 0,
                ),
                const SizedBox(height: 80),
              ],
            ),
          )
        ],
      ),
    );
  }
}
