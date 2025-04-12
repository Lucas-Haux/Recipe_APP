import 'package:flutter/material.dart';

import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:recipe_box/shared/ui/recipe_search_bar.dart';

class RecipeSearchAppBar extends StatelessWidget {
  final bool isModified;
  final TextEditingController searchController;
  final Function(Map<String, dynamic>) updateSearchParameters;
  final Function(String) clearSearchParameters;
  final bool matchTitle;

  const RecipeSearchAppBar({
    required this.isModified,
    required this.searchController,
    required this.updateSearchParameters,
    required this.clearSearchParameters,
    required this.matchTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final clearParametersBorderSide = BorderSide(
      width: 2,
      color: Theme.of(context).colorScheme.primary,
    );
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      pinned: true,
      floating: true,
      snap: false,
      expandedHeight: 250.0,
      collapsedHeight: 120.0 + (isModified ? 22.0 : 0.0),
      leading: const SizedBox.shrink(), // hide backbutton in bar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),

      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        background: Center(
          child: TextAnimator(
            'Search For A Recipe',
            incomingEffect: WidgetTransitionEffects.incomingOffsetThenScale(
                duration: const Duration(milliseconds: 600)),
            outgoingEffect: WidgetTransitionEffects.outgoingOffsetThenScale(
                duration: const Duration(milliseconds: 600)),
            atRestEffect: WidgetRestingEffects.none(),
            textAlign: TextAlign.center,
            initialDelay: const Duration(milliseconds: 50),
            spaceDelay: const Duration(milliseconds: 65),
            characterDelay: const Duration(milliseconds: 65),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              shadows: [
                Shadow(
                    blurRadius: 9,
                    color: Colors.white.withAlpha(70),
                    offset: Offset(-3, -3)),
                Shadow(
                    blurRadius: 9,
                    color: Colors.white.withAlpha(70),
                    offset: Offset(3, -3)),
                Shadow(
                    blurRadius: 9,
                    color: Colors.white.withAlpha(70),
                    offset: Offset(-3, 3)),
                Shadow(
                    blurRadius: 9,
                    color: Colors.white.withAlpha(70),
                    offset: Offset(3, 3)),
              ],
            ),
          ),
        ),

        titlePadding: const EdgeInsets.only(), // removes left padding
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 150, minHeight: 100),
              padding: const EdgeInsets.only(
                top: 45.0,
                left: 30.0,
                right: 30.0,
              ),

              // Search Field
              child: Hero(
                tag: 'SearchBar',
                child: RecipeSearchBar(
                  key: const ValueKey('SearchBar'),
                  searchPage: true,
                  controller: searchController,
                  updateSearchParameters: updateSearchParameters,
                  matchTitle: matchTitle,
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(
                        duration: Duration(milliseconds: 500)),
                outgoingEffect:
                    WidgetTransitionEffects.outgoingSlideOutToBottom(
                        duration: Duration(milliseconds: 500)),
                child: isModified
                    ? Container(
                        width: 175,
                        height: 22,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          border: Border(
                            left: clearParametersBorderSide,
                            right: clearParametersBorderSide,
                            bottom: clearParametersBorderSide,
                            top: BorderSide.none,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(
                                20), // Keeps only the bottom rounded corners
                          ),
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: TextButton(
                            onPressed: () =>
                                clearSearchParameters(searchController.text),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Clear Filters',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
