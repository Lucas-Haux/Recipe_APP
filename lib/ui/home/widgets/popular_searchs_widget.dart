import 'package:flutter/material.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:recipe_box/domain/popular_searches_data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PopularSearchesWidget extends StatefulWidget {
  final double height;

  const PopularSearchesWidget({
    required this.height,
    super.key,
  });

  @override
  _PopularSearchesWidgetState createState() => _PopularSearchesWidgetState();
}

class _PopularSearchesWidgetState extends State<PopularSearchesWidget> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Listen to changes in the controller
    carouselController.addListener(_updateIndex);
  }

  @override
  void dispose() {
    carouselController.removeListener(_updateIndex);
    super.dispose();
  }

  void _updateIndex() {
    if (carouselController.positions.isNotEmpty) {
      int newIndex = (carouselController.offset / 375).round();
      if (newIndex != currentIndex) {
        setState(() {
          currentIndex = newIndex;
        });
        print("Current Index: $currentIndex");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = popularSearchesData.entries.toList()[currentIndex].key;
    SearchParameters searchParameters =
        popularSearchesData.entries.toList()[currentIndex].value;

    Set<String> extractDisplayNames<T>(
        Map<DisplayableEnum, dynamic> map, dynamic excludeValue) {
      return map.entries
          .where((entry) => entry.value != excludeValue)
          .map((entry) => entry.key.displayName)
          .toSet();
    }

    Set<String> searchParametersDisplayNames = {
      ...extractDisplayNames(
          searchParameters.cuisines, RequireExclude.unspecified),
      ...extractDisplayNames(searchParameters.equipment, AndOrType.unspecified),
      ...extractDisplayNames(
          searchParameters.intolerances, RequireExclude.unspecified),
      ...extractDisplayNames(searchParameters.diets, AndOrType.unspecified),
      ...extractDisplayNames(searchParameters.meals, AndOrType.unspecified),
    };

    // TODO make the blue colors darker
    return Container(
      constraints: BoxConstraints(maxHeight: widget.height / 3),
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(20),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: Stack(
        children: [
          // Carousel
          ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(20)), // Apply rounded corners here
            child: CarouselView(
              itemExtent: 375,
              controller: carouselController,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
              ),
              itemSnapping: true,
              children: popularSearchesData.entries.map((entry) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [0.01, 0.3],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    popularSearchesImages[entry.key]!,
                    height: widget.height / 3,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ),

          // Title & Filters
          AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1,
                  children: [
                    // Title
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.lightBlueAccent
                        ], // Gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Filters Row
                    Row(
                      children: List.generate(
                        searchParametersDisplayNames.length,
                        (int index) => Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.lightBlueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            searchParametersDisplayNames
                                .elementAt(index)
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Top Right Buttons
          Align(
            alignment: Alignment.topRight,
            child: Wrap(
              direction: Axis.vertical,
              textDirection: TextDirection.rtl,
              children: [
                _topRightButton(Icons.edit_note, "Edit Filters"),
                _topRightButton(Icons.search, "Search"),
              ],
            ),
          ),
          // Carousel Indicator
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(15),
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

  Widget _topRightButton(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
