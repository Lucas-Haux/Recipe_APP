import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';
import 'package:recipe_box/view/pages/search_page.dart';
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
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            onTapAlwaysCalled: true,
            style: const TextStyle(fontSize: 25),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: 'Search',
              label: const Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 3),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                    width: 1),
              ),
            ),
            onSubmitted: (_) async {
              fetchRecipes(widget.controller.text.trim());
              await Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  pageBuilder: (_, __, ___) => const SearchResultsPage(),
                ),
              );
            },
            onTap: () {
              widget.onTap();
            },
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search_sharp,
                size: 33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
