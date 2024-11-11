import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/home_page.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'package:recipe_box/view/pages/search_results_page.dart';

final FocusNode _focusNode = FocusNode();

enum MealType { dinner, lunch, breakfast, snack } // no teatim to fit width

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Request focus only if the widget is still part of the widget tree
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10,
                  left:
                      63.0), // Add some padding to position it within the screen
              child: FloatingActionButton.small(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            FloatingActionButton.extended(
              heroTag: 'SearchButton',
              onPressed: () {
                fetchRecipes(searchController.text.trim());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchResultsPage()));
              },
              icon: const Icon(Icons.search),
              extendedPadding: const EdgeInsets.only(left: 15, right: 15),
              label: const Text('Search'),
            ),
          ],
        ),
      ),
      // back button
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            pinned: true,
            snap: false,
            expandedHeight: 180.0,
            leading: const SizedBox(), // hide back in bar
            flexibleSpace: FlexibleSpaceBar(
              background: const Center(
                child: Text(
                  'Search For A Recipe!',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                height: 40,
                child: SearchTextField(
                  controller: widget.searchController,
                  focusNode: _focusNode,
                  onTap: () {},
                ),
              ),
            ),
          ),
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
