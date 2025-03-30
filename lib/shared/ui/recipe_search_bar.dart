import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  final bool searchPage;
  final TextEditingController? controller;
  final Function(Map<String, dynamic>)? updateQuery;

  const RecipeSearchBar({
    required this.searchPage,
    this.controller, // required if searchPage == true
    this.updateQuery, // required if searchPage == true
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      //type: MaterialType.button,
      child: Stack(
        children: [
          TextField(
            controller: controller,
            autofocus: searchPage,
            readOnly: !searchPage,
            onTapAlwaysCalled: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 25),
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
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
            onTapOutside: (_) {
              if (updateQuery != null) {
                updateQuery!({'query': controller!.value.text});
              }
              // WARNING might cause problems
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (_) {
              if (updateQuery != null) {
                updateQuery!({'query': controller!.value.text});
              }
              Navigator.pushNamed(context, '/searchPage/searchResults');
            },
            onTap: () {
              if (!searchPage) {
                Navigator.pushNamed(context, '/searchPage');
              }
            },
          ),
          // Search Icon
          // Have to do it this way due to jaring scaling with the flexable space bar
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
