import 'package:flutter/gestures.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/similar_recipe_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';

import '../view_model/recipe_viewmodel.dart';

import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/search_bar_field_widget.dart';

double cardWidth = 360;

const TextStyle _titleStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class RecipeScreen extends ConsumerWidget {
  final int recipeListIndex;
  const RecipeScreen({
    required this.recipeListIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipeViewModelProvider(recipeListIndex));

    int i = 0;
    print(recipeListIndex);

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
              SizedBox(
                width: cardWidth,
                child: Card(
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  child: Column(
                    children: [
                      // Image
                      _RecipeImage(
                          imageUrl: recipe.imageUrl, favoriteButton: true),
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
                width: cardWidth,
                height: 190,
                child: Row(
                  children: [
                    _ServingsInfoCard(recipe: recipe),
                    const Spacer(),
                    _MicInfoCard(recipe: recipe),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Equipment
              _EquipmentCard(recipe: recipe),

              //Ingredients
              _IngredentsCard(recipe: recipe),

              const SizedBox(height: 15),

              //Instructions
              _InstructionCard(
                  getParagraphDataForRecipe: ref
                      .read(recipeViewModelProvider(recipeListIndex).notifier)
                      .getParagraphDataForRecipe,
                  recipe: recipe),

              _SimilarRecipes(id: recipe.id),
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
              readOnly: true,
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
  final bool favoriteButton;
  const _RecipeImage({required this.imageUrl, required this.favoriteButton});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            imageUrl,
            width: cardWidth,
          ),
          // favorites button
          if (favoriteButton == true)
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
    );
  }
}

class _DietLabels extends StatelessWidget {
  final RecipeModel recipe;
  const _DietLabels({required this.recipe});

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
      width: cardWidth / 2.05,
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
            const Text('Per Serving:'),
            const SizedBox(height: 10),
            Text(' ${recipe.calories} '),
            Text(' ${recipe.protein} '),
            Text(' ${recipe.fat} '),
            Text(' \$${recipe.pricePerServing.toStringAsPrecision(2)} USD'),
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
      width: cardWidth / 2.05,
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
            Text('Total Ingredients: ${recipe.ingredients.length}'),
            const Spacer(),
            Text('Weight Watcher: ${recipe.weightWatcher.toString()}'),
            const Spacer(),
            Text('Health Score: ${recipe.healthScore.toString()}'),
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

    if (equipmentList.isNotEmpty) {
      return SizedBox(
        width: cardWidth,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Text('Equipment:', style: _titleStyle),
              const Divider(),
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

class _IngredentsCard extends StatelessWidget {
  final RecipeModel recipe;
  const _IngredentsCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
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

class _InstructionCard extends StatefulWidget {
  final Future<void> Function(int) getParagraphDataForRecipe;
  final RecipeModel recipe;

  const _InstructionCard({
    required this.getParagraphDataForRecipe,
    required this.recipe,
  });
  @override
  _InstructionCardState createState() => _InstructionCardState();
}

class _InstructionCardState extends State<_InstructionCard> {
  InstructionView selectedView = InstructionView.list;

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Column(
        children: [
          const SizedBox(height: 5),

          // InstructionView Picker Button
          Card(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SegmentedButton<InstructionView>(
                showSelectedIcon: false,
                segments: const <ButtonSegment<InstructionView>>[
                  ButtonSegment(
                    value: InstructionView.list,
                    label: Text('List'),
                  ),
                  ButtonSegment(
                    value: InstructionView.paragraph,
                    label: Text('Paragraph'),
                  ),
                ],
                selected: {selectedView},
                onSelectionChanged: (newSelection) async {
                  setState(() {
                    selectedView = newSelection.first;
                  });
                  if (widget.recipe.instructionsParagraph.isEmpty) {
                    await widget.getParagraphDataForRecipe(widget.recipe.id);
                  }
                },
              ),
            ),
          ),
          // List view
          if (selectedView == InstructionView.list) ...[
            Card(
              color: Theme.of(context).colorScheme.onSecondaryFixed,
              child: Column(
                children: widget.recipe.instructions.map<Widget>((instruction) {
                  i++;

                  return _ListInstructions(
                    recipeInstructionsParagraph:
                        widget.recipe.instructionsParagraph,
                    getParagraphDataForRecipe: widget.getParagraphDataForRecipe,
                    title: instruction.title,
                    steps: instruction.steps,
                    instructionNum: i,
                    recipeID: widget.recipe.id,
                  );
                }).toList(),
              ),
            ),
          ],
          // Paragraph view
          if (selectedView == InstructionView.paragraph) ...[
            Card(
              color: Theme.of(context).colorScheme.onSecondaryFixed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: widget.recipe.instructionsParagraph.isNotEmpty
                    ? HtmlWidget(widget.recipe.instructionsParagraph)
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
  final Future<void> Function(int) getParagraphDataForRecipe;
  final String title;
  final List<StepModel> steps;
  final int instructionNum;
  final int recipeID;
  final String recipeInstructionsParagraph;
  const _ListInstructions({
    required this.getParagraphDataForRecipe,
    required this.title,
    required this.steps,
    required this.instructionNum,
    required this.recipeID,
    required this.recipeInstructionsParagraph,
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
    print('OG: ${title} || New: $instructionTitle');

    return Column(
      children: [
        Text(instructionTitle, style: _titleStyle),
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
                width: cardWidth / 1.345,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarRecipes extends StatefulWidget {
  final int id;
  const _SimilarRecipes({required this.id});

  @override
  State<_SimilarRecipes> createState() => _SimilarRecipesState();
}

class _SimilarRecipesState extends State<_SimilarRecipes> {
  List<SimilarRecipeModel> similarRecipes = [];

  final PageController carouselController =
      PageController(initialPage: 1, viewportFraction: 1 / 2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          children: [
            if (similarRecipes.isEmpty)
              FilledButton(
                onPressed: () async {
                  // final newList =
                  //    await RecipeViewmodel().searchSimilarRecipes(widget.id);
                  setState(() {
                    // similarRecipes = newList;
                  });
                },
                child: const Text('Find Similar Recipes'),
              ),

            // Carousel
            if (similarRecipes.isNotEmpty)
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 300, maxWidth: cardWidth),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.1, 0.9, 1],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: PageView.builder(
                    controller: carouselController,
                    pageSnapping: false,
                    dragStartBehavior: DragStartBehavior.start,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    allowImplicitScrolling: true,
                    itemCount: similarRecipes.length,
                    itemBuilder: (context, index) {
                      return _SimilarRecipeCard(recipe: similarRecipes[index]);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SimilarRecipeCard extends StatelessWidget {
  final SimilarRecipeModel recipe;
  const _SimilarRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RecipeImage(imageUrl: recipe.imageUrl, favoriteButton: false),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(recipe.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
