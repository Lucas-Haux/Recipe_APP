import 'package:flutter/material.dart';

import 'package:recipe_box/features/home_page/widgets/popular_searches/popular_searches_manager.dart';
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OverlayWidget extends ConsumerWidget {
  final int currentIndex;
  const OverlayWidget({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(popularSearchesManagerProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(15),
      child: Stack(
        children: [
          // Title & Filters
          Align(
            alignment: Alignment.bottomLeft,
            child: _TitleAndFiltersDisplay(
              searchParametersData:
                  popularSearchesData.entries.toList()[currentIndex].value,
              title: popularSearchesData.entries.toList()[currentIndex].key,
            ),
          ),

          // Top Right Buttons
          Align(
            alignment: Alignment.topRight,
            child: Wrap(
              direction: Axis.vertical,
              textDirection: TextDirection.rtl,
              spacing: 15,
              children: [
                // Edit Filters Button
                _TopRightButton(
                  icon: Symbols.edit_note_rounded,
                  text: "Edit Filters",
                  color1: Colors.blue.shade400,
                  color2: Colors.blue.shade500,
                  onTap: () {
                    manager.setFilters(
                      popularSearchesData.entries.toList()[currentIndex].value,
                    );
                    Navigator.pushNamed(context, '/searchPage');
                  },
                ),
                // Search Button
                _TopRightButton(
                  icon: Symbols.search_rounded,
                  color1: Colors.blue.shade600,
                  color2: Colors.blue.shade700,
                  text: "Search",
                  onTap: () {
                    manager.setFilters(
                      popularSearchesData.entries.toList()[currentIndex].value,
                    );
                    Navigator.pushNamed(context, '/searchPage/searchResults');
                  },
                ),
              ],
            ),
          ),
          // Carousel Indicator
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 4.3, // to align  with the filter chips hight
                right: 1, // to fit in padding correctly
              ),
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                effect: ExpandingDotsEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  dotColor: Colors.blueGrey,
                  activeDotColor: Colors.blue,
                ),
                count: popularSearchesData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAndFiltersDisplay extends StatelessWidget {
  final SearchParameters searchParametersData;
  final String title;
  const _TitleAndFiltersDisplay({
    required this.searchParametersData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Set<String> extractDisplayNamesFromChangedEnums<T>(
        Map<DisplayableEnum, dynamic> map, dynamic excludeValue) {
      return map.entries
          .where((entry) => entry.value != excludeValue)
          .map((entry) => entry.key.displayName)
          .toSet();
    }

    // List of all the searchParameters this recipe search has
    Set<String> searchParametersDataDisplayNames = {
      ...extractDisplayNamesFromChangedEnums(
          searchParametersData.cuisines, RequireExclude.unspecified),
      ...extractDisplayNamesFromChangedEnums(
          searchParametersData.equipment, AndOrType.unspecified),
      ...extractDisplayNamesFromChangedEnums(
          searchParametersData.intolerances, RequireExclude.unspecified),
      ...extractDisplayNamesFromChangedEnums(
          searchParametersData.diets, AndOrType.unspecified),
      ...extractDisplayNamesFromChangedEnums(
          searchParametersData.meals, AndOrType.unspecified),
    };

    List<Color> getColorsFromIndex(int index) {
      switch (index) {
        case 0:
          return [Colors.blue.shade700, Colors.blue.shade600];
        case 1:
          return [Colors.blue.shade600, Colors.blue.shade500];
        case 2:
          return [Colors.blue.shade500, Colors.blue.shade400];

        default:
          return [Colors.blue.shade700, Colors.blue.shade600];
      }
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1,
        children: [
          // Title
          Text(
            title,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),

          // Filters Row
          Row(
            spacing: 8,
            children: List.generate(
              searchParametersDataDisplayNames.length,
              (int index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: getColorsFromIndex(index),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  searchParametersDataDisplayNames
                      .elementAt(index)
                      .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRightButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color1;
  final Color color2;
  final void Function() onTap;
  const _TopRightButton({
    required this.icon,
    required this.text,
    required this.color1,
    required this.color2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(icon, weight: 600),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
