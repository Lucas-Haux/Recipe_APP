import '../../domain/models/favorites.dart';

List<Favorites> _favoritesList = [];

class RecipeFavoritesRepository {
  List<Favorites> getFavoritesList() {
    return _favoritesList;
  }

  void addToFavoritesList() {
    const first = Favorites(id: 1, date: 2);
    _favoritesList.add(first);
  }
}
