import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/search_results_page.dart';

class SearchTextField extends StatefulWidget {
  final VoidCallback onTap;
  final FocusNode focusNode;
  final TextEditingController controller;

  const SearchTextField({
    super.key,
    required this.onTap,
    required this.focusNode,
    required this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'SearchTextField',
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: widget.controller,
          focusNode: focusNode,
          textAlignVertical: TextAlignVertical.top, //center verticaly
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: 'Search',
            prefixIcon: const Icon(Icons.search),
            suffix: const Icon(null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          onSubmitted: (_) async {
            fetchRecipes(widget.controller.text.trim());
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchResultsPage()));
          },
          onTap: () {
            widget.onTap();
          },
        ),
      ),
    );
  }
}
