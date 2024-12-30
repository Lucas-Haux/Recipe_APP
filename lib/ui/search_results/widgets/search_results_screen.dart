import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';
import 'package:recipe_box/data/model/data_state_status_model.dart';
import '../../home/widgets/home_screen.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/recipe_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/search_results_view_model.dart';
import '../../core/ui/search_bar_field_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the recipe search when the tree is done building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This runs after the widget tree is built
      ref.read(recipeViewModelProvider.notifier).searchForRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipeViewModelProvider);
    ref.watch(recipeViewModelProvider); // Watch the ViewModel provider

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
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
                  return const Center(child: CircularProgressIndicator());
                } else if (recipeState.status == DataStateStatus.completed) {
                  if (recipeState.data != null) {
                    final showPopularBadge =
                        _showPopularBadge(recipeState.data!);

                    return Center(
                      child: SizedBox(
                        width: 350,
                        child: Wrap(
                          children: List.generate(
                            recipeState.data!.length,
                            (index) {
                              return _RecipeInfoCard(
                                recipeListIndex: index,
                                recipe: recipeState.data![index],
                                showPopularBadge: showPopularBadge,
                              );
                            },
                          ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search Button
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 45,
          width: 300,
          child: Hero(
            tag: 'SearchBar',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: SearchBarFieldWidget(
                focusNode: focusNode1,
                goToSearchPage: true,
                controller: searchController,
                autofocus: false,
                readOnly: true,
                onTap: () {
                  context.go('/search');
                },
              ),
            ),
          ),
        ),

        const Spacer(),

        // Home Button
        IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())),
          icon: const Icon(Icons.home),
        ),

        const Spacer(),
      ],
    );
  }
}

class _RecipeInfoCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool showPopularBadge;
  final int recipeListIndex;
  const _RecipeInfoCard({
    required this.recipe,
    required this.showPopularBadge,
    required this.recipeListIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: GestureDetector(
        onTap: () {
          context.pushNamed('Recipe', extra: {
            'recipeListIndex': recipeListIndex,
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RecipeImage(
                imageUrl: recipe.imageUrl,
                time: recipe.time,
                popular: recipe.popular,
                showPopularBadge: showPopularBadge,
              ),
              Text(
                recipe.title,
                textAlign: TextAlign.center,
              ),
              const Divider(),
              const Text(
                'Per Serving:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                recipe.calories,
                textAlign: TextAlign.center,
              ),
              Text(
                recipe.protein,
                textAlign: TextAlign.center,
              ),
              Text(
                recipe.fat,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String imageUrl;
  final int time;
  final bool popular;
  final bool showPopularBadge;
  const _RecipeImage({
    required this.imageUrl,
    required this.time,
    required this.popular,
    required this.showPopularBadge,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: 175,
        child: Stack(
          children: [
            // Picture
            Image.network(imageUrl),

            // Time Banner
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding:
                  const EdgeInsets.only(left: 6, right: 8, bottom: 8, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${time}m',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Popular Badge
            if (popular == true && showPopularBadge == true) ...[
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(end: 52),
                  stackFit: StackFit.expand,
                  badgeStyle: const badges.BadgeStyle(
                    shape: badges.BadgeShape.instagram,
                    badgeGradient: badges.BadgeGradient.linear(
                      colors: [Colors.deepPurpleAccent, Colors.redAccent],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  badgeContent: const SizedBox(
                    width: 45,
                    height: 45,
                    child: Center(
                      child: Text(
                        'POPULAR',
                        style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                            height: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
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
  if (numberOfPopular < 5) {
    return true;
  } else {
    return false;
  }
}
