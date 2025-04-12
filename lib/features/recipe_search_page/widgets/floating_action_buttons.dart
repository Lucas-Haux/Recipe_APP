import 'package:flutter/material.dart';

class FloatingActionButtons extends StatelessWidget {
  final Function(Map<String, dynamic>) updateQuery;
  final TextEditingController textEditingController;
  const FloatingActionButtons({
    required this.updateQuery,
    required this.textEditingController,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        // Home
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: FloatingActionButton.small(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        //Search
        FloatingActionButton.extended(
          heroTag: 'SearchButton',
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus(); // remove keyboard

            await updateQuery({'query': textEditingController.text});

            Navigator.pushNamed(context, '/searchPage/searchResults');
          },
          icon: const Icon(Icons.search),
          extendedPadding: const EdgeInsets.only(left: 10, right: 15),
          label: const Text('Search'),
        ),
      ],
    );
  }
}
