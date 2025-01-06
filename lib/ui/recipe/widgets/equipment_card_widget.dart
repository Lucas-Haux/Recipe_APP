import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

import '../../../domain/models/recipe_model.dart';

class EquipmentCard extends StatelessWidget {
  final double cardWidth;
  final TextStyle titleStyle;
  final List<InstructionModel> instructions;
  const EquipmentCard({
    required this.cardWidth,
    required this.instructions,
    required this.titleStyle,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Set<String> equipmentList = instructions
        .expand((instruction) => instruction.steps)
        .expand((step) => step.equipment)
        .toSet();

    if (equipmentList.isNotEmpty) {
      return SizedBox(
        width: cardWidth,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            children: [
              const SizedBox(height: 5),
              // Title
              Text('Equipment:', style: titleStyle),
              const Divider(),
              // Row of Equipment
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: equipmentList.map((equipment) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            StringUtils.capitalize(equipment, allWords: true),
                            style: const TextStyle(fontSize: 14)),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      );
      // if equipmentList is empty
    } else {
      return const SizedBox();
    }
  }
}
