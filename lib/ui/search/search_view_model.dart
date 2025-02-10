import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/search_pramaters_repository.dart';

import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@Riverpod(keepAlive: true)
class SearchViewModel extends _$SearchViewModel {
  @override
  SearchParameters build() {
    print('ran build');
    return ref.watch(searchParametersRepositoryProvider).getSearchParameters();
  }

  void updateSearchParameters(Map<String, dynamic> updates) {
    try {
      print('view model update rna');

      print('nah ${updates.keys.first}');
      ref.watch(searchParametersRepositoryProvider).updateState(
            query: updates['query'],
            dietAndOr: updates['dietAndOr'],
            maxTime: updates['maxTime'],
            maxCalories: updates['maxCalories'],
            minCalories: updates['minCalories'],
            maxServings: updates['maxServings'],
            minServings: updates['minServings'],
            maxProtein: updates['maxProtein'],
            minProtein: updates['minProtein'],
            maxFat: updates['maxFat'],
            minFat: updates['minFat'],
            cuisines: updates['Cuisines'],
            diets: updates['Diets'],
            intolerances: updates['Intolerances'],
          );
      state =
          ref.watch(searchParametersRepositoryProvider).getSearchParameters();
    } catch (e) {
      throw e;
    }
  }

  Future<void> searchForRecipes() async {
    throw UnimplementedError();
  }
}
