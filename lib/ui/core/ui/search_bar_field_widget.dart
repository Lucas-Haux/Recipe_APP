import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarFieldWidget extends StatefulWidget {
  final bool goToSearchPage;
  final void Function()? onTap;
  final VoidCallback? searchForRecipes;
  final TextEditingController controller;

  const SearchBarFieldWidget({
    super.key,
    required this.goToSearchPage,
    required this.controller,
    this.onTap,
    this.searchForRecipes,
  });

  @override
  State<SearchBarFieldWidget> createState() => _SearchBarFieldWidget();
}

class _SearchBarFieldWidget extends State<SearchBarFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            autofocus: !widget.goToSearchPage,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            readOnly: widget.goToSearchPage,
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
              if (widget.searchForRecipes != null) {
                widget.searchForRecipes!();
              }
            },
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus(); // remove keyboard
              if (widget.goToSearchPage == true) {
                context.go('/search');
              } else {
                widget.onTap;
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
