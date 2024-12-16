import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';

import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/search_bar_field_widget.dart';

const TextStyle _titleStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class RecipeScreen extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeScreen({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    int i = 0;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const _AppBar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // First Card
              Container(
                constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
                child: Card(
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  child: Column(
                    children: [
                      // Image
                      _RecipeImage(imageUrl: recipe.imageUrl),
                      // Title
                      Text(
                        recipe.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: _titleStyle,
                      ),
                    ],
                  ),
                ),
              ),
              // Diets
              if (recipe.diets.isNotEmpty && recipe.diets[0].isNotEmpty)
                _DietLabels(recipe: recipe),

              // Row of Serving and misc cards
              SizedBox(
                width: 320,
                height: 173,
                child: Row(
                  children: [
                    _ServingsInfoCard(recipe: recipe),
                    const Spacer(),
                    _MicInfoCard(recipe: recipe),
                  ],
                ),
              ),

              // Equipment
              _EquipmentCard(recipe: recipe),

              //Ingredients
              _IngredentsCard(recipe: recipe),

              //Instructions
              Column(
                children: recipe.instructions.map<Widget>((instruction) {
                  i++;

                  return _InstructionCard(
                    title: instruction.title,
                    steps: instruction.steps,
                    instructionNum: i,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search Button
        SizedBox(
          height: 45,
          width: 275,
          child: Hero(
            tag: 'SearchBar',
            child: SearchBarFieldWidget(
              autofocus: false,
              goToSearchPage: true,
              controller: TextEditingController(), // TODO this should change
            ),
          ),
        ),
        const Spacer(),

        // Home Button
        IconButton(
          onPressed: () => print('go home'),
          icon: const Icon(Icons.home),
        ),
        const Spacer()
      ],
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String imageUrl;
  const _RecipeImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 231,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              imageUrl,
              width: 320,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  print('favorite button pressed');
                  // change favorite state of recipe id
                },
                color: Colors.redAccent,
                icon: const Icon(
                  Icons.favorite_outline,
                  size: 35,
                ),
                selectedIcon: const Icon(
                  Icons.favorite,
                  size: 35,
                ),
                isSelected:
                    false, // need to change to favorite state of recipe id
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DietLabels extends StatelessWidget {
  final RecipeModel recipe;
  const _DietLabels({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minWidth: 320, maxWidth: 320, minHeight: 45),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: List.generate(
              recipe.diets.length,
              (index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Text(
                      '  ${StringUtils.capitalize(recipe.diets[index], allWords: true)}  '),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ServingsInfoCard extends StatelessWidget {
  final RecipeModel recipe;
  const _ServingsInfoCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 29,
              child: Text(
                recipe.servings > 1
                    ? '${recipe.servings} Servings' // plural
                    : '${recipe.servings} Serving', // Single
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            const Text('Per Serving: \n'),
            Text(' ${recipe.calories} '),
            Text(' ${recipe.protein} '),
            Text(' ${recipe.fat} '),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _MicInfoCard extends StatelessWidget {
  final RecipeModel recipe;
  const _MicInfoCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Source Url Button
            SizedBox(
              height: 29,
              child: FilledButton(
                onPressed: () async {
                  final Uri url = Uri.parse(recipe.sourceUrl);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                ),
                child: Text(
                  recipe.sourceName,
                  style: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const Divider(),
            const Spacer(),
            Text('Time To Cook: ${recipe.time}m'),
            const Spacer(),
            Text('Health Score: num'),
            const Spacer(),
            Text('Total Ingredients: num'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _EquipmentCard extends StatelessWidget {
  final RecipeModel recipe;
  const _EquipmentCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    Set<String> equipmentList = recipe.instructions
        .expand((instruction) =>
            instruction.steps) // Flatten steps from instructions
        .expand((step) => step.equipment) // Flatten equipment from steps
        .toSet();

    return Container(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text('Equipment:', style: _titleStyle),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
  }
}

class _IngredentsCard extends StatelessWidget {
  final RecipeModel recipe;
  const _IngredentsCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text('Ingredients:', style: _titleStyle),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: recipe.ingredients.map((ingredient) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        StringUtils.capitalize(ingredient, allWords: true),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
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
  }
}

class _InstructionCard extends StatelessWidget {
  final String title;
  final List<StepModel> steps;
  final int instructionNum;
  const _InstructionCard({
    required this.title,
    required this.steps,
    required this.instructionNum,
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
    String instructionTitle = extractTitle(title).isNotEmpty
        ? extractTitle(title)
        : '${order(instructionNum)} Instruction';
    print('OG: $title || New: $instructionTitle');

    return Container(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(instructionTitle, style: _titleStyle),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _StepInstruction extends StatefulWidget {
  final StepModel step;
  const _StepInstruction({required this.step, super.key});

  @override
  State<_StepInstruction> createState() => __StepInstructionState();
}

ButtonStyle buttonStyle = const ButtonStyle(
  padding: WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
  minimumSize: WidgetStatePropertyAll<Size>(Size(32, 32)),
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
          print(isHidden);
        });
      },
      child: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            margin: const EdgeInsets.only(left: 4, right: 4, top: 4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 227,
                child: Text(
                  widget.step.stepInstruction,
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
                FilledButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: widget.step.stepInstruction));
                    setState(() {
                      isHidden = true;
                    });
                  },
                  style: buttonStyle,
                  child: const Icon(Icons.copy, size: 18),
                ),
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
                    isDone ? Icons.cancel_outlined : Icons.done,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
