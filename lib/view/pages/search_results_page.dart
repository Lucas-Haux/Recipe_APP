import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:async';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/recipe_page.dart';
import 'home_page.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'search_page.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  SearchResultsPageState createState() => SearchResultsPageState();
}

class SearchResultsPageState extends State<SearchResultsPage> {
  List<String> _imageList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await recipeSearchNotifi.future; // waits till recipeSearch is done
    setState(() {
      _imageList = imageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Row(
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
                child: SearchTextField(
                  controller: searchController,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => SearchPage(
                          searchController: searchController,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            // Home Button
            IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
              icon: const Icon(Icons.home),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // generate recipe cards
            Expanded(
              child: _imageList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 175,
                            child: Column(
                              children: List.generate(
                                _imageList.length,
                                (index) {
                                  if (index.isEven) {
                                    return RecipeCard(
                                      index: index,
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
                                imageList.length,
                                (index) {
                                  if (index.isOdd) {
                                    return RecipeCard(
                                      index: index,
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
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final int index;

  const RecipeCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 290,
      child: GestureDetector(
        onTap: () async => await Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (_, __, ___) => RecipePage(index: index)),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 175,
                  child: RecipeImageGraphic(index: index),
                ),
              ),
              Text(
                labelList[index],
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              if (servingsList[index] > 1) ...[
                Text('${servingsList[index].toString()} Servings:'),
                const Spacer(),
                Text(' ${calorieList[index]} per srv.'),
                Text(' ${proteinList[index]} per srv.'),
                Text(' ${fatList[index]} per srv.'),
                const Spacer(),
              ] else ...[
                Text('${servingsList[index].toString()} Serving:'),
                const Spacer(),
                Text(' ${calorieList[index]} '),
                Text(' ${proteinList[index]} '),
                Text(' ${fatList[index]} '),
                const Spacer(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeImageGraphic extends StatelessWidget {
  final int index;
  const RecipeImageGraphic({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(imageList[index]),

        // Time Banner
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(left: 6, right: 8, bottom: 8, top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                '${timeList[index]}m',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Popular Badge
        if (popularList[index] == true &&
            popularList.where((item) => item).length < 5) ...[
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
                    'Highly \n Popular',
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold, height: 0.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
