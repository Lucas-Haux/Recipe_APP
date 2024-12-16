import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/recipe_favorites_repository.dart';
import '../../../domain/models/favorites.dart';

class HomeViewModel extends StateNotifier<List<Favorites>> {
  final RecipeFavoritesRepository favoritesRepository;

  HomeViewModel(this.favoritesRepository)
      : super(favoritesRepository.getFavoritesList());

  void addToFavorites() {
    favoritesRepository.addToFavoritesList();
    state = List.from(favoritesRepository.getFavoritesList());
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, List<Favorites>>((ref) {
  final favoritesRepository = RecipeFavoritesRepository();
  return HomeViewModel(favoritesRepository);
});
