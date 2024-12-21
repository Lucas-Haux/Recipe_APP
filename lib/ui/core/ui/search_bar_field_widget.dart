import 'package:go_router/go_router.dart';
import '../../search/widgets/search_screen.dart';

import 'package:flutter/material.dart';

final FocusNode focusNode1 = FocusNode();

class SearchBarFieldWidget extends StatefulWidget {
  final bool goToSearchPage;
  final bool autofocus;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final VoidCallback? searchForRecipes;
  final TextEditingController? controller;
  final bool readOnly;

  const SearchBarFieldWidget({
    super.key,
    this.searchForRecipes,
    this.focusNode,
    required this.autofocus,
    this.onTap,
    required this.goToSearchPage,
    required this.controller,
    required this.readOnly,
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
          :qTextField(
            controller: widget.controller,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
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
            onTap: widget.onTap,
            // if (goToSearchPage == true) {
            // Code that works
            // doesnt use go router due to problems
            //Navigator.push(
            //  context,
            //  PageRouteBuilder(
            //    transitionDuration: const Duration(milliseconds: 800),
            //    pageBuilder: (_, __, ___) =>
            //        SearchScreen(searchController: controller),
            //  ),
            //);
            //    }
            // }
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
