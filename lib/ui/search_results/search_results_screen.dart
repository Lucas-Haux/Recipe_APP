import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/home_screen.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/recipe_model.dart';
import 'search_results_view_model.dart';
import '../core/ui/search_bar_field_widget.dart';
import 'widgets/recipe_display_card_widget.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  SearchResultsScreenState createState() => SearchResultsScreenState();
}

class SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the recipe search when the tree is done building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.watch(searchResultsViewModelProvider.notifier).searchForRecipes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(searchResultsViewModelProvider); // Watch the ViewModel provider

    final recipeState = ref.watch(searchResultsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(),
        title: _AppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Builder(
              builder: (context) {
                if (recipeState.status == DataStateStatus.loading) {
                  return const Center(
                    heightFactor: 7,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  );
                } else if (recipeState.status == DataStateStatus.completed) {
                  int? totalRecipeResults = ref
                      .read(searchResultsViewModelProvider.notifier)
                      .getTotalRecipeResults();

                  int leftIndex = -2;
                  int rightIndex = -1;

                  if (recipeState.data != null) {
                    final bool showPopularBadge =
                        _showPopularBadge(recipeState.data!);

                    List<RecipeModel> leftList = [];
                    List<RecipeModel> rightList = [];

                    int index = 0;
                    for (var recipe in recipeState.data!) {
                      if (index.isEven) {
                        leftList.add(recipe);
                      } else if (index.isOdd) {
                        rightList.add(recipe);
                      }
                      index++;
                    }

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 3),
                            if (totalRecipeResults != null)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 15),
                                  children: <TextSpan>[
                                    const TextSpan(text: 'Total Results: '),
                                    TextSpan(
                                      text: totalRecipeResults.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 8),
                            // Two Columns showing recipe cards
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: List.generate(
                                    leftList.length,
                                    (index) {
                                      leftIndex += 2;
                                      return RecipeDisplayCard(
                                        recipe: leftList[index],
                                        showPopularBadge: showPopularBadge,
                                        recipeListIndex: leftIndex,
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: List.generate(
                                    rightList.length,
                                    (index) {
                                      rightIndex += 2;
                                      return RecipeDisplayCard(
                                        recipe: rightList[index],
                                        showPopularBadge: showPopularBadge,
                                        recipeListIndex: rightIndex,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Text('No Recipe Data Found For Your Search');
                  }
                } else if (recipeState.status == DataStateStatus.error) {
                  return Center(
                      child: Text('Error: ${recipeState.errorMessage}'));
                }
                return Container(); // Fallback for unexpected states
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          // Search Button
          SizedBox(
            height: 45,
            width: 300,
            child: Hero(
              tag: 'SearchBar',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: SearchBarFieldWidget(
                  goToSearchPage: true,
                  controller: searchController,
                ),
              ),
            ),
          ),
          const Spacer(),

          // Home Button
          Hero(
            tag: const Key('HomeButton'),
            child: IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              icon: Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

bool _showPopularBadge(List<RecipeModel> recipeData) {
  int numberOfPopular = 0;
  for (var recipe in recipeData) {
    if (recipe.popular == true) {
      numberOfPopular++;
    }
  }
  print('total number of popular: $numberOfPopular');
  if (numberOfPopular < 17) {
    return true;
  } else {
    return false;
  }
}
