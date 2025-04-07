import 'package:flutter/material.dart';

import 'package:recipe_box/features/home_page/widgets/popular_searches/overlay_widget.dart';
import 'package:recipe_box/features/home_page/widgets/popular_searches/popular_searches_manager.dart';
import 'package:recipe_box/features/recipe_display_page/recipe_display_screen.dart';

class PopularSearchesCard extends StatefulWidget {
  final double height;

  const PopularSearchesCard({
    required this.height,
    super.key,
  });

  @override
  PopularSearchesCardState createState() => PopularSearchesCardState();
}

class PopularSearchesCardState extends State<PopularSearchesCard> {
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO make the blue colors darker
    return Container(
      constraints: BoxConstraints(maxHeight: widget.height / 3),
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
              padding: EdgeInsets.zero,
              enableSplash: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.zero),
              ),
              itemSnapping: true,
              children: popularSearchesData.entries.map((entry) {
                // fades away on the left and right side of the carousel
                return Stack(
                  children: [
                    ShaderMask(
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
                      // Carousel only changes the image but a controller listener updates the index
                      child: Image.asset(
                        popularSearchesImages[entry.key]!,
                        height: widget.height / 3,
                        width: cardWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // Overlay
          OverlayWidget(currentIndex: currentIndex),
        ],
      ),
    );
  }
}
