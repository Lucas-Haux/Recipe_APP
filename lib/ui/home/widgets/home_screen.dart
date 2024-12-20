import 'package:flutter/material.dart';
import '../view_model/home_view_model.dart';
import 'package:go_router/go_router.dart';
import '../../core/ui/search_bar_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO should these be in viewmodel?
TextEditingController searchController = TextEditingController();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesList = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
            // Search Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: 'SearchBar',
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: SearchBarFieldWidget(
                    focusNode: focusNode1,
                    goToSearchPage: true,
                    controller: searchController,
                    autofocus: false,
                    readOnly: true,
                    onTap: () {
                      context.go('/search');
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),

            // Favorites
            Text('${favoritesList.length}'),

            // Test Button
            FilledButton(
              onPressed: () {
                context.go('/search');
                ref.read(homeViewModelProvider.notifier).addToFavorites();
              },
              child: const Text('test'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
