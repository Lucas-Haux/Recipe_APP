import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/recipe_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'package:recipe_box/view/pages/search_page.dart';
import 'package:recipe_box/view/pages/home_page.dart';

class paginationResultsPage extends StatefulWidget {
  final String paginationHref;

  const paginationResultsPage({required this.paginationHref, super.key});

  @override
  _paginationResultsPageState createState() => _paginationResultsPageState();
}

class _paginationResultsPageState extends State<paginationResultsPage> {
  String _nextHref = nextHref;
  List<String> _hrefList = [];
  List<String> _imageList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchRecipeLabel();
  }

  Future<void> _fetchRecipeLabel() async {
    try {
      // Send a GET request to the URI
      final response = await http.get(Uri.parse(widget.paginationHref));

      if (response.statusCode == 200) {
        // Parse the JSON data from the response
        final data = json.decode(response.body);

        // Extract the recipe label from the JSON data
        setState(() {
          for (var hit in data['hits']) {
            var href = hit['_links']['self']['href'];
            _hrefList.add(href);
          }
          print('href new list:$_hrefList');

          print('test');

          for (var hit in data['hits']) {
            var href = hit['recipe']['image'];
            _imageList.add(href);
          }
          print('new image list:$_imageList');
          print('test');

          nextHref = data['_links']['next']['href'];
          print('next href: $nextHref');
        });
      } else {}
    } catch (e) {}
  }

  Future<void> _loadData() async {
    // Fetch data here, like calling `fetchRecipes`.
    // For example purposes, we mock some data loading.
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      print("pagination ${widget.paginationHref}");
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
      body: Column(
        children: [
          Text('Recipe List'),
          Expanded(
            child: _hrefList.isEmpty || _imageList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _hrefList.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        imageurl: _imageList[index],
                        hrefurl: _hrefList[index],
                      );
                    },
                  ),
          ),
          FilledButton(
            onPressed: () {
              final thinggg = widget.paginationHref;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => paginationResultsPage(
                            paginationHref: nextHref,
                          )));
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imageurl;
  final String hrefurl;

  const RecipeCard({
    required this.imageurl,
    required this.hrefurl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipePage(hrefurl: hrefurl))),
        child: Card(
          color: Colors.red,
          child: Row(
            children: [const Text('name'), Image.network(imageurl)],
          ),
        ),
      ),
    );
  }
}
