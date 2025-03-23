import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';

import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@Riverpod(keepAlive: true)
class SearchViewModel extends _$SearchViewModel {
  @override
  SearchParameters build() {
    return ref.watch(searchParametersRepositoryProvider).getSearchParameters();
  }

  Future<void> clearDB() async {
    await ref.read(recipeDataRepositoryProvider).clearDB();
  }

  void updateSearchParameters(Map<String, dynamic> newParameter) {
    try {
      ref.watch(searchParametersRepositoryProvider).updateState(
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
          );
      state =
          ref.watch(searchParametersRepositoryProvider).getSearchParameters();
    } catch (e) {
      throw e;
    }
  }

  void addIngredient() {
    Map<String, RequireExclude> newEntries = {'': RequireExclude.require};

    Map<String, RequireExclude> ingredients = state.ingredients!;
    ingredients.addEntries(newEntries.entries);

    updateSearchParameters({'Ingredients': ingredients});
  }

  void updateIngredientName(
    String oldName,
    String newName,
    RequireExclude value,
  ) {
    Map<String, RequireExclude> ingredients = state.ingredients!;
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
    Map<String, RequireExclude> ingredients = state.ingredients!;
    ingredients.update(name, (value) => newValue);

    updateSearchParameters({'Ingredients': ingredients});
  }

  void removeIngredient(String name) {
    Map<String, RequireExclude> ingredients = state.ingredients!;
    ingredients.remove(name);

    updateSearchParameters({'Ingredients': ingredients});
  }
}
