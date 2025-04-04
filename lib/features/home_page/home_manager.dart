import 'package:recipe_box/shared/databases/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
