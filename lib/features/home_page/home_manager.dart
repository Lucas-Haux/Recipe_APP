import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/services/recipe_favorites/recipe_favorites_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//import 'package:recipe_box/data/repositories/favorites_repository/favorites_repository.dart';
//import 'package:recipe_box/domain/models/recipe_model.dart';
//import '../../../data/repositories/recipe_favorites_repository.dart';
//import '../../../domain/models/favorites.dart';

part 'home_manager.g.dart';

@Riverpod()
class HomeManager extends _$HomeManager {
  @override
  AsyncValue<List<Recipe>> build() {
    return AsyncValue.loading();
  }

  getFavoritesList() async {
    try {
      final favorites =
          await ref.watch(favoritesDatabaseProvider).getFavorites();

      state = AsyncValue.data(favorites);
    } catch (e) {
      throw 'Couldnt get favorites';
    }
  }
}
