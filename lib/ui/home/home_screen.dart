import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';
import 'package:recipe_box/ui/home/widgets/favorites_widget.dart';
import 'package:recipe_box/ui/home/widgets/popular_searchs_widget.dart';
import 'home_viewmodel.dart';
import '../core/ui/search_bar_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO should these be in viewmodel?
TextEditingController searchController = TextEditingController();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesList = ref.watch(homeViewModelProvider).value;
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gap on Top
            const SizedBox(height: 60),
            // Search Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: 'SearchBar',
                child: SearchBarFieldWidget(
                  key: const ValueKey('SearchBar'),
                  searchPage: false,
                  controller: searchController,
                ),
              ),
            ),
            const Spacer(),

            PopularSearchesWidget(height: height),
            Spacer(),

            if (favoritesList != null)
              // TODO add place holder for empty favorites
              FavoritesWidget(height: height, favoritesList: favoritesList),

            const Spacer(),
            // Settings and tokens Buttons
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: height / 4.5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.blueGrey,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      const SizedBox(width: 7),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  constraints: BoxConstraints(maxHeight: height / 4.5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow,
                        Colors.orange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.generating_tokens_outlined),
                      const SizedBox(width: 7),
                      Text(
                        'Tokens',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(this.text,
      {super.key, required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style:
            style.copyWith(color: Colors.white), // Base color won't be visible
      ),
    );
  }
}
