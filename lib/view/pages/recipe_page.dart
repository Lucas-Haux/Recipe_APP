import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipePage extends StatefulWidget {
  final String hrefurl;
  const RecipePage({required this.hrefurl, super.key});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String recipeLabel = '';

  @override
  void initState() {
    super.initState();
    _fetchRecipeLabel();
  }

  Future<void> _fetchRecipeLabel() async {
    try {
      // Send a GET request to the URI
      final response = await http.get(Uri.parse(widget.hrefurl));

      if (response.statusCode == 200) {
        // Parse the JSON data from the response
        final data = json.decode(response.body);

        // Extract the recipe label from the JSON data
        setState(() {
          recipeLabel = data['recipe']['label'];
        });
      } else {
        setState(() {
          recipeLabel = 'Failed to load recipe';
        });
      }
    } catch (e) {
      setState(() {
        recipeLabel = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: Column(
        children: [
          recipeLabel.isNotEmpty
              ? Text(recipeLabel)
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}
