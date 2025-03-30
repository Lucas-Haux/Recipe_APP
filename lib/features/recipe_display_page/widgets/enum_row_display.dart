import 'package:flutter/material.dart';

import 'package:basic_utils/basic_utils.dart';

class EnumRowDisplay extends StatelessWidget {
  final List<dynamic> listEnum;
  final double cardWidth;
  const EnumRowDisplay({
    required this.listEnum,
    required this.cardWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: cardWidth, maxWidth: cardWidth, minHeight: 45),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: List.generate(
              listEnum.length,
              (index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Text(
                    '  ${StringUtils.capitalize(
                      listEnum[index],
                      allWords: true, // Cap First letter of all words
                    )}  ',
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
