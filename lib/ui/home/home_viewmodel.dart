import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/favorites_repository/favorites_repository.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/recipe_favorites_repository.dart';
import '../../../domain/models/favorites.dart';

part 'home_viewmodel.g.dart';

@Riverpod()
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<List<RecipeModel>> build() async {
    return ref.watch(favoritesRepositoryProvider).getFavorites();
  }
}
