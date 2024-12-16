import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/recipe_data_repository.dart';

class SearchState {
  final String query;

  SearchState({this.query = ''});
}

class SearchViewModel extends StateNotifier<SearchState> {
  SearchViewModel() : super(SearchState());

  void updateSearchQuery(String newQuery) {
    try {
      query = newQuery;
      print('11111111111');
      print(query);
    } catch (e) {
      throw 'Couldnt update search query: $e';
    }
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
  return SearchViewModel();
});
