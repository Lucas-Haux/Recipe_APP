import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/nutrition_graph.dart';
import 'package:recipe_box/shared/models/recipe.dart';

import 'package:url_launcher/url_launcher.dart';

class MicInfoCard extends StatelessWidget {
  final double cardWidth;
  final String sourceUrl;
  final String sourceName;
  final int time;
  final List<String> ingredients;
  final int weightWatcher;
  final double healthScore;
  final List<NutritionModel> nutrients;
  const MicInfoCard({
    required this.cardWidth,
    required this.sourceUrl,
    required this.sourceName,
    required this.time,
    required this.ingredients,
    required this.weightWatcher,
    required this.healthScore,
    required this.nutrients,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth / 2.05,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),

            // nutrition button
            SizedBox(
              height: 29,
              child: FilledButton(
                onPressed: () {
                  showDialog(
                    useSafeArea: false,
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: NutritionGraph(nutrients: nutrients),
                    ),
                  );
                },
                child: const Text(
                  'Nutrition Data',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const Divider(),
            const SizedBox(height: 4),

            // Source Url Button
            SizedBox(
              height: 29,
              child: OutlinedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(sourceUrl);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                  foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                  side: WidgetStatePropertyAll(BorderSide(
                      color: Theme.of(context).colorScheme.tertiary)),
                ),
                child: AutoSizeText(
                  sourceName,
                  style: const TextStyle(height: 0.5),
                  maxLines: 1,
                ),
              ),
            ),

            const Spacer(),
            _TextNumbersRichText(start: 'Ready In: ', end: '${time}m'),
            const Spacer(),
            _TextNumbersRichText(
                start: 'Weight Watcher Score: ', end: weightWatcher.toString()),

            const Spacer(),
            _TextNumbersRichText(
                start: 'Health Score: ', end: healthScore.toInt().toString()),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _TextNumbersRichText extends StatelessWidget {
  final String start;
  final String end;
  const _TextNumbersRichText({
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 15;
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            // Numbers
            TextSpan(
              text: start,
              style: TextStyle(
                fontSize: fontSize - 1,
                fontWeight: FontWeight.normal,
              ),
            ),

            TextSpan(
              text: end,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
