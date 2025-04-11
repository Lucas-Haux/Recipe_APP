import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:recipe_box/shared/models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum InstructionsView {
  list,
  paragraph,
}

class InstructionsCard extends StatefulWidget {
  final Future<void> Function() getParagraphDataForRecipe;
  final double cardWidth;
  final String? instructionsParagraph;
  final List<Instruction> instructions;

  const InstructionsCard({
    required this.getParagraphDataForRecipe,
    required this.cardWidth,
    required this.instructions,
    this.instructionsParagraph,
    super.key,
  });
  @override
  InstructionsCardState createState() => InstructionsCardState();
}

class InstructionsCardState extends State<InstructionsCard> {
  InstructionsView selectedView = InstructionsView.list;

  @override
  Widget build(BuildContext context) {
    int instructionNum = 0;
    return SizedBox(
      width: widget.cardWidth,
      child: Column(
        children: [
          const SizedBox(height: 5),

          // InstructionsView Picker Button
          SegmentedButton<InstructionsView>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<InstructionsView>>[
              ButtonSegment(
                value: InstructionsView.list,
                label: Text('List'),
              ),
              ButtonSegment(
                value: InstructionsView.paragraph,
                label: Text('Paragraph'),
              ),
            ],
            selected: {selectedView},
            onSelectionChanged: (newSelection) async {
              setState(() {
                selectedView = newSelection.first;
              });
              if (widget.instructionsParagraph == null) {
                await widget.getParagraphDataForRecipe();
              }
            },
          ),

          // List view
          if (selectedView == InstructionsView.list) ...[
            Card(
              margin: EdgeInsets.only(top: 0, left: 4, right: 4),
              color: Theme.of(context).colorScheme.onSecondaryFixed,
              child: Column(
                children: widget.instructions.map<Widget>((instruction) {
                  instructionNum++;

                  return _ListInstructions(
                    getParagraphDataForRecipe: widget.getParagraphDataForRecipe,
                    title: instruction.title!,
                    steps: instruction.steps!,
                    instructionNum: instructionNum,
                    numberOfInsturctions: widget.instructions.length,
                    cardWidth: widget.cardWidth,
                  );
                }).toList(),
              ),
            ),
          ],

          // Paragraph view
          if (selectedView == InstructionsView.paragraph) ...[
            Card(
              margin: EdgeInsets.only(top: 0, left: 4, right: 4),
              color: Theme.of(context).colorScheme.onSecondaryFixed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: widget.instructionsParagraph != null
                    ? HtmlWidget(
                        widget.instructionsParagraph!,
                      )
                    : const Center(
                        heightFactor: 2,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 7,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      ),
              ),
            ),
          ],
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class _ListInstructions extends StatelessWidget {
  final Future<void> Function() getParagraphDataForRecipe;
  final String title;
  final List<InstructionStep> steps;
  final int instructionNum;
  final int numberOfInsturctions;
  final double cardWidth;
  const _ListInstructions({
    required this.getParagraphDataForRecipe,
    required this.title,
    required this.steps,
    required this.instructionNum,
    required this.numberOfInsturctions,
    required this.cardWidth,
  });

  String extractTitle(String input) {
    // Regular expression to match everything after the last meaningful phrase
    RegExp regExp = RegExp(r'([A-Za-z]+(?:\s+[A-Za-z]+)*)$');
    Match? match = regExp.firstMatch(input);

    // If a match is found, return it; otherwise, return an empty string.
    return match?.group(0) ?? '';
  }

  String order(int num) => switch (num) {
        1 => 'First',
        2 => 'Second',
        3 => 'Third',
        4 => 'Fourth',
        5 => 'Fith',
        _ => '',
      };

  @override
  Widget build(BuildContext context) {
    String instructionTitle() {
      String extractedTitle = extractTitle(title);
      // if recipe has instruction title
      if (extractedTitle.isNotEmpty) {
        return extractedTitle;
        // if recipe only has one set of instructions
      } else if (numberOfInsturctions < 2) {
        return 'Instructions';
        // if recipe has more then one set of instructions
      } else {
        return '${order(instructionNum)} Instructions';
      }
    }

    return Column(
      children: [
        const SizedBox(height: 3),
        if (instructionNum != 1) const Divider(),
        Text(
          instructionTitle(),
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: List.generate(steps.length, (index) {
              return Row(
                children: [
                  // Step number
                  Card(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        steps[index].stepNumber.toString(),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  // Step
                  _StepInstruction(
                    step: steps[index],
                    key: Key(index.toString()),
                    cardWidth: cardWidth,
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _StepInstruction extends StatefulWidget {
  final InstructionStep step;
  final double cardWidth;
  const _StepInstruction(
      {required this.cardWidth, required this.step, super.key});

  @override
  State<_StepInstruction> createState() => __StepInstructionState();
}

ButtonStyle buttonStyle = const ButtonStyle(
  padding: WidgetStatePropertyAll<EdgeInsets>(
    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  ),
  minimumSize: WidgetStatePropertyAll<Size>(
    Size(32, 32),
  ),
);

class __StepInstructionState extends State<_StepInstruction> {
  bool isHidden = true;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isHidden == true) {
            isHidden = false;
          } else if (isHidden == false) {
            isHidden = true;
          }
        });
      },
      child: Column(
        children: [
          Card(
            color: isDone
                ? Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.6)
                : Theme.of(context).colorScheme.secondaryContainer,
            margin: const EdgeInsets.only(left: 4, right: 4, top: 4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.cardWidth / 1.345,
                child: Text(
                  widget.step.stepInstruction!,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !isHidden,
            child: Row(
              children: [
                // Mark Done Button
                FilledButton(
                  onPressed: () => setState(() {
                    if (isDone == true) {
                      isDone = false;
                    } else if (isDone == false) {
                      isDone = true;
                    }
                    isHidden = true;
                  }),
                  style: buttonStyle,
                  child: Icon(
                    isDone ? Icons.remove_done_rounded : Icons.done_rounded,
                    size: 18,
                  ),
                ),
                // Copy to Clipboard
                FilledButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: widget.step.stepInstruction!));
                    setState(() {
                      isHidden = true;
                    });
                  },
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.tertiary),
                  ),
                  child: const Icon(Icons.copy, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
