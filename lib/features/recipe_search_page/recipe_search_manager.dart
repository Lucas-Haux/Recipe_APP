import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';
import 'package:recipe_box/shared/databases/searchs-parameters/search_parameters_database.dart';

part 'recipe_search_manager.g.dart';

@riverpod
class RecipeSearchManager extends _$RecipeSearchManager {
  @override
  SearchParameters build() {
    return ref.watch(searchParametersDatabaseProvider).getSearchParameters();
  }

  clearSearchParameters(String query) async {
    try {
      await ref.read(searchParametersDatabaseProvider).resetToDefaults(query);
      state = ref.watch(searchParametersDatabaseProvider).getSearchParameters();
    } catch (e) {
      throw 'Failed to clear searchParameters in manager';
    }
  }

  void updateSearchParameters(Map<String, dynamic> newParameter) {
    try {
      ref.watch(searchParametersDatabaseProvider).updateState(
            query: newParameter['query'],
            dietAndOr: newParameter['dietAndOr'],
            maxTime: newParameter['maxTime'],
            calories: newParameter['Calories'],
            servings: newParameter['Servings'],
            protein: newParameter['Protein'],
            fat: newParameter['Fat'],
            meals: newParameter['Meal Type'],
            cuisines: newParameter['Cuisines'],
            diets: newParameter['Diets'],
            equipment: newParameter['Equipment'],
            ingredients: newParameter['Ingredients'],
            intolerances: newParameter['Intolerances'],
            newSortType: newParameter['Shorting'],
            matchTitle: newParameter['matchTitle'],
          );
      state = ref.watch(searchParametersDatabaseProvider).getSearchParameters();
    } catch (e) {
      throw 'Failed to update Search sparameters in manager: $e';
    }
  }

  void addIngredient() {
    Map<String, RequireExclude> newEntries = {'': RequireExclude.require};

    Map<String, RequireExclude> ingredients = state.ingredients;
    ingredients.addEntries(newEntries.entries);

    updateSearchParameters({'Ingredients': ingredients});
  }

  void updateIngredientName(
    String oldName,
    String newName,
    RequireExclude value,
  ) {
    Map<String, RequireExclude> ingredients = state.ingredients;
    final updatedIngredients = <String, RequireExclude>{};

    ingredients.forEach((key, value) {
      if (key != oldName) {
        // add the entry without changes
        updatedIngredients[key] = value;
      } else if (key == oldName) {
        // add the entry with the new name
        updatedIngredients[newName] = value;
      }
    });

    updateSearchParameters({'Ingredients': updatedIngredients});
  }

  void updateIngredientValue(String name, RequireExclude newValue) {
    Map<String, RequireExclude> ingredients = state.ingredients;
    ingredients.update(name, (value) => newValue);

    updateSearchParameters({'Ingredients': ingredients});
  }

  void removeIngredient(String name) {
    Map<String, RequireExclude> ingredients = state.ingredients;
    ingredients.remove(name);

    updateSearchParameters({'Ingredients': ingredients});
  }

  void refreshFromDatabase() {
    state = ref.read(searchParametersDatabaseProvider).getSearchParameters();
  }
}
