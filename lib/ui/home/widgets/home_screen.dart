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
            const SizedBox(height: 60),
            // Search Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: 'SearchBar',
                flightShuttleBuilder: ((flightContext, animation,
                    flightDirection, fromHeroContext, toHeroContext) {
                  /// Don't try to add a Listener here, use a StatefulWidget that uses that logic in its initState
                  return _FocustWidget(
                    animation: animation,
                    focusNode: focusNode1,
                    child: toHeroContext.widget,
                  );
                }),
                child: SearchBarFieldWidget(
                  key: const ValueKey('SearchBar'),
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

class _FocustWidget extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;
  final FocusNode focusNode;

  const _FocustWidget({
    Key? key,
    required this.focusNode,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  State<_FocustWidget> createState() => __FocustWidgetState();
}

class __FocustWidgetState extends State<_FocustWidget> {
  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_status);

    ///Check for the animation state
  }

  void _status(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.microtask(() => mounted ? widget.focusNode.requestFocus() : null);
    }
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_status);

    /// dispose the listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
