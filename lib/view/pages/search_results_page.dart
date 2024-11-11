import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/recipe_page.dart';
import 'package:recipe_box/view/pages/results_pagination.dart';
import 'home_page.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'search_page.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<String> _hrefList = [];
  List<String> _imageList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Fetch data here, like calling `fetchRecipes`.
    // For example purposes, we mock some data loading.
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      _hrefList = hrefList;
      _imageList = imageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Container(
              height: 75,
              width: 250,
              child: SearchTextField(
                controller: searchController,
                focusNode: FocusNode(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                        searchController: searchController,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
                icon: Icon(Icons.home))
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Recipe List'),
            Expanded(
              child: _hrefList.isEmpty || _imageList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 175,
                            child: Column(
                              children: List.generate(
                                _hrefList.length,
                                (index) {
                                  if (index.isEven) {
                                    return RecipeCard(
                                      calories: calorieList[index],
                                      cuisineType: cuisineList[index],
                                      dishType: dishList[index],
                                      time: timeList[index],
                                      label: labelList[index],
                                      imageurl: _imageList[index],
                                      hrefurl: _hrefList[index],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 175,
                            child: Column(
                              children: List.generate(
                                _hrefList.length,
                                (index) {
                                  if (index.isOdd) {
                                    return RecipeCard(
                                      calories: calorieList[index],
                                      cuisineType: cuisineList[index],
                                      dishType: dishList[index],
                                      time: timeList[index],
                                      label: labelList[index],
                                      imageurl: _imageList[index],
                                      hrefurl: _hrefList[index],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
            ),
            FilledButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          paginationResultsPage(paginationHref: nextHref))),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String cuisineType;
  final String label;
  final String dishType;
  final String imageurl;
  final String hrefurl;
  final String time;
  final String calories;

  const RecipeCard({
    required this.dishType,
    required this.calories,
    required this.time,
    required this.cuisineType,
    required this.label,
    required this.imageurl,
    required this.hrefurl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 300,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipePage(hrefurl: hrefurl))),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                child: SizedBox(
                  width: 175,
                  child: Stack(
                    children: [
                      Image.network(imageurl),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.cyan, // Set background color
                          borderRadius: BorderRadius.only(
                            // Rounded only on the right side
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 6, right: 8, bottom: 8, top: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 20,
                              color: Colors.white, // Icon color
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${time}m',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                label,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (dishType.isNotEmpty) Text('Dish Type: $dishType'),
              const Spacer(),
              if (cuisineType.isNotEmpty) Text('Cuisine Type: $cuisineType'),
              const Spacer(),
              if (calories.isNotEmpty) Text('Calories: $calories'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
