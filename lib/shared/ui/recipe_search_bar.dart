import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeSearchBar extends StatelessWidget {
  final bool searchPage;
  final TextEditingController? controller;
  final Function(Map<String, dynamic>)? updateSearchParameters;
  final bool? matchTitle;

  const RecipeSearchBar({
    required this.searchPage,
    this.controller, // required if searchPage == true
    this.updateSearchParameters, // required if searchPage == true
    this.matchTitle, // require if searchspage == true
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      //type: MaterialType.button,
      child: TextField(
        controller: controller,
        autofocus: searchPage,
        readOnly: !searchPage,
        canRequestFocus: searchPage,
        onTapAlwaysCalled: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 25),
        textAlignVertical:
            searchPage ? TextAlignVertical.center : TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        maxLines: 2,
        minLines: 1,
        decoration: InputDecoration(
          filled: true,
          //contentPadding:
          //EdgeInsets.only(left: 50, right: 70, top: 8, bottom: 8),
          prefixIcon: SizedBox(
            width: 58,
            height: 58,
            child: Icon(
              Icons.search_sharp,
              size: 40,
            ),
          ),
          suffixIcon: Container(
            margin: EdgeInsets.only(right: 3),
            width: 58,
            height: 58,
            child: (searchPage == true && matchTitle != null)
                ? ChoiceChip(
                    padding: EdgeInsets.zero,
                    label: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        'Match\nTitle',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w900),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    selected: matchTitle!,
                    showCheckmark: false,
                    onSelected: (selected) =>
                        updateSearchParameters!({'matchTitle': !matchTitle!}),
                    shape: CircleBorder(),
                  )
                : null,
          ),

          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Search',
          //label: const Align(
          //  alignment: AlignmentDirectional.center,
          //  child: Text(
          //    'Search',
          //    style: TextStyle(fontSize: 25),
          //  ),
          //),
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
                color: Theme.of(context).colorScheme.primaryFixedDim, width: 1),
          ),
        ),
        onTapOutside: (_) {
          if (updateSearchParameters != null) {
            updateSearchParameters!({'query': controller!.value.text});
          }
          // WARNING might cause problems
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onSubmitted: (_) {
          if (updateSearchParameters != null) {
            updateSearchParameters!({'query': controller!.value.text});
          }
          Navigator.pushNamed(context, '/searchPage/searchResults');
        },
        onTap: () {
          if (!searchPage) {
            Navigator.pushNamed(context, '/searchPage');
          }
        },
      ),
    );
  }
}
