import 'package:flutter/material.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class NutritionTabel extends StatelessWidget {
  final List<NutritionModel> nutrients;

  const NutritionTabel({required this.nutrients, super.key});

  @override
  Widget build(BuildContext context) {
    double rowHeight = 27;
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SingleChildScrollView(
          child: DataTable(
            border: TableBorder.all(
              color: Colors.black38,
              width: 1.8,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            dataRowMaxHeight: rowHeight,
            dataRowMinHeight: rowHeight,
            headingRowColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primaryContainer,
            ),
            headingRowHeight: rowHeight + 7,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                    child: Text('Nutrition',
                        style: TextStyle(fontStyle: FontStyle.italic))),
              ),
              DataColumn(
                label: Expanded(
                    child: Text('Amount',
                        style: TextStyle(fontStyle: FontStyle.italic))),
              ),
              DataColumn(
                label: Expanded(
                    child: Text('Intake',
                        style: TextStyle(fontStyle: FontStyle.italic))),
              ),
            ],
            rows: List<DataRow>.generate(
              nutrients.length,
              (index) {
                return DataRow(
                  color: WidgetStatePropertyAll(
                    (index.isOdd)
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        nutrients[index].label!,
                        style: TextStyle(
                          color: (index.isEven)
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(190),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(Text(
                        '${nutrients[index].amount!.round()}${nutrients[index].unit!}')),
                    DataCell(Text('${nutrients[index].percentage!}%',
                        style: TextStyle(color: Colors.grey))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
