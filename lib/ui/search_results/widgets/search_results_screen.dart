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
    ref.watch(recipeViewModelProvider); // Watch the ViewModel provider

    final recipeState = ref.watch(recipeViewModelProvider);

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
                  return const Center(child: CircularProgressIndicator());
                } else if (recipeState.status == DataStateStatus.completed) {
                  print(' length!!!!!!!: ${recipeState.data!.length}');

                  int leftIndex = -2;
                  int rightIndex = -1;

                  if (recipeState.data != null) {
                    final showPopularBadge =
                        _showPopularBadge(recipeState.data!);

                    List<RecipeModel> leftList = [];
                    List<RecipeModel> rightList = [];

                    int index = 0;
                    for (var recipe in recipeState.data!) {
                      if (index.isEven) {
                        leftList.add(recipe);
                        print('index: $index , added to left');
                      } else if (index.isOdd) {
                        rightList.add(recipe);
                      }
                      index++;
                    }

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: List.generate(
                                leftList.length,
                                (index) {
                                  leftIndex += 2;
                                  return _RecipeInfoCard(
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
                                  return _RecipeInfoCard(
                                    recipe: rightList[index],
                                    showPopularBadge: showPopularBadge,
                                    recipeListIndex: rightIndex,
                                  );
                                },
                              ),
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
      width: 185,
      child: GestureDetector(
        onTap: () {
          context.pushNamed('Recipe', extra: {
            'recipeListIndex': recipeListIndex,
            'id': recipe.id.toString(),
          });
        },
        child: Card(
          margin: const EdgeInsets.all(5),
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
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const Text(
                'Per Serving:',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
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
    String newTime = '';
    if (time >= 61) {
      double hour = time / 60;
      double min = time % 60;

      newTime = '${hour.round()}h:${min.round()}m';
    } else {
      newTime = '${time}m';
    }

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.4), // Shadow color with opacity
                    spreadRadius: 1, // How far the shadow spreads
                    blurRadius: 5, // How soft the shadow appears
                    offset:
                        const Offset(2, 2), // Horizontal and vertical offset
                  ),
                ],
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
                    newTime,
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
