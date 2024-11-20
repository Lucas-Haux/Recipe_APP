import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/home_page.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'package:recipe_box/view/pages/search_results_page.dart';

final FocusNode _focusNode = FocusNode();

enum MealType { dinner, lunch, breakfast, snack }

List<MealType?> selectedMealTypes = [];

enum CuisineType {
  american,
  asian,
  british,
  caribbean,
  centralEurope,
  chinese,
  easternEurope,
  french,
  greek,
  indian,
  italian,
  japanese,
  korean,
  kosher,
  mediterranean,
  mexican,
  middleEastern,
  nordic,
  southAmerican,
  southEastAsian,
}

List<CuisineType> selectedCuisineType = [];

class SearchPage extends StatefulWidget {
  final TextEditingController searchController;

  const SearchPage({
    super.key,
    required this.searchController,
  });

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Search home Button
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [
            // Home
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 63.0),
              child: FloatingActionButton.small(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          pageBuilder: (_, __, ___) => const HomePage()));
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
            //Search
            FloatingActionButton.extended(
              heroTag: 'SearchButton',
              onPressed: () {
                fetchRecipes(searchController.text.trim());
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) =>
                            const SearchResultsPage()));
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.search),
              extendedPadding: const EdgeInsets.only(left: 15, right: 15),
              label: const Text('Search'),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            pinned: true,
            snap: false,
            expandedHeight: 180.0,
            leading: const SizedBox(), // hide backbutton in bar
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              background: const Center(
                child: Text(
                  'Search For A Recipe!',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 8.0),
                height: 70,

                // Search Field
                child: Hero(
                  tag: 'SearchBar',
                  child: SearchTextField(
                    controller: widget.searchController,
                    focusNode: _focusNode,
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),

          // Search Options
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Divider(),
                  const Text(
                    'Meal Type',
                    textScaleFactor: 2,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: MealType.values.map((mealType) {
                      return ChoiceChip(
                        label: Text(
                          mealType.name[0].toUpperCase() +
                              mealType.name.substring(1),
                        ),
                        selected: selectedMealTypes!.contains(mealType),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              // Add to the list if selected
                              selectedMealTypes!.add(mealType);
                            } else {
                              // Remove from the list if deselected
                              selectedMealTypes!.remove(mealType);
                              print('selected meal type: $selectedMealTypes');
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const Divider(),
                  const Text(
                    'Cuisine Type',
                    textScaleFactor: 2,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: CuisineType.values.map((cuisineType) {
                      return ChoiceChip(
                        label: Text(
                          cuisineType.name[0].toUpperCase() +
                              cuisineType.name.substring(1),
                        ),
                        selected: selectedCuisineType.contains(cuisineType),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              // Add to the list if selected
                              selectedCuisineType.add(cuisineType);
                            } else {
                              // Remove from the list if deselected
                              selectedCuisineType.remove(cuisineType);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
