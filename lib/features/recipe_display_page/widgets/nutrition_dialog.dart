import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/nutrition_graph.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/nutrition_tabel.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class NutritionDialog extends StatefulWidget {
  final List<NutritionModel> nutrients;
  const NutritionDialog({required this.nutrients, super.key});

  @override
  State<NutritionDialog> createState() => _NutritionDialogState();
}

class _NutritionDialogState extends State<NutritionDialog> {
  bool barchartView = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: AnimatedSize(
        duration: Duration(milliseconds: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            // Button
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<bool>>[
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Barchart View'),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Tabel View'),
                ),
              ],
              selected: <bool>{barchartView},
              onSelectionChanged: (_) {
                setState(() {
                  barchartView = !barchartView;
                });
              },
            ),

            // Title
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
              outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
              child: barchartView
                  ? AutoSizeText(
                      " Percentage of Recommended Daily Intake ",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : SizedBox(key: Key('none')),
            ),

            // Barchart & Tabel
            SizedBox(
              height: 700,
              child: (barchartView)
                  ? // Barchart View
                  Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 25,
                        top: 10,
                        bottom: 10,
                      ),
                      child: NutritionGraph(oldNutrients: widget.nutrients),
                    )
                  : // Tabel View
                  Padding(
                      padding: EdgeInsets.all(7),
                      child: NutritionTabel(nutrients: widget.nutrients),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
