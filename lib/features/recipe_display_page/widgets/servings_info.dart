import 'package:flutter/material.dart';

class ServingsInfoCard extends StatelessWidget {
  final double cardWidth;
  final int servings;
  final int calories;
  final int fat;
  final int protein;
  final double pricePerServing;
  const ServingsInfoCard(
      {required this.cardWidth,
      required this.servings,
      required this.calories,
      required this.fat,
      required this.protein,
      required this.pricePerServing,
      super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth / 2.05,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 29,
              child: Text(
                servings > 1
                    ? '$servings Servings' // plural
                    : '$servings Serving', // Single
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const Divider(),
            const Text(
              'Per Serving:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ' \$${pricePerServing.toStringAsFixed(2)} USD',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade300,
              ),
            ),
            _NumbersTextRichText(
                start: '$calories',
                end: (calories > 1) ? ' Calories' : ' Calorie'),
            _NumbersTextRichText(start: '${protein}g', end: ' of Protein'),
            _NumbersTextRichText(start: '${fat}g', end: ' of Fat'),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _NumbersTextRichText extends StatelessWidget {
  final String start;
  final String end;
  const _NumbersTextRichText({
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    double _fontSize = 15;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5, top: 1.5),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            // Numbers
            TextSpan(
              text: start,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextSpan(
              text: end,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
