import 'package:flutter/material.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'package:recipe_box/model/favorites.dart';
import 'package:recipe_box/view/pages/search_page.dart';

TextEditingController searchController = TextEditingController();
final FocusNode searchFocusNode = FocusNode();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
            const SizedBox(height: 20),
            const FavoriteSection(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class FavoriteSection extends StatelessWidget {
  const FavoriteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Favorites',
          textScaleFactor: 3,
        ),
        const Divider(),
        favorites == null
            ? const Card(
                child: Text('No favorites'),
              )
            : const Card(
                child: Text('something'),
              )
      ],
    );
  }
}
