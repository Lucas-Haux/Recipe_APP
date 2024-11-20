import 'package:basic_utils/basic_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipe_box/view/pages/search_page.dart';
import 'package:recipe_box/view/pages/home_page.dart';
import 'package:recipe_box/view/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/model/recipe_search.dart';

class RecipePage extends StatefulWidget {
  final int index;

  const RecipePage({
    required this.index,
    super.key,
  });

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
  }

  bool favoriteSelecected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Button
            SizedBox(
              height: 45,
              width: 275,
              child: Hero(
                tag: 'SearchBar',
                child: SearchTextField(
                  controller: searchController,
                  focusNode: FocusNode(),
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          pageBuilder: (_, __, ___) =>
                              SearchPage(searchController: searchController))),
                ),
              ),
            ),
            const Spacer(),

            // Home Button
            IconButton(
              onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) =>
                          SearchPage(searchController: searchController))),
              icon: const Icon(Icons.home),
            ),
            const Spacer()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
              child: Card(
                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 231,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              imageList[widget.index],
                              width: 320,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  print('favorite button pressed');
                                  setState(() {
                                    favoriteSelecected = !favoriteSelecected;
                                  });
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
                                isSelected: favoriteSelecected,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    labelList[widget.index].isNotEmpty
                        ? Text(
                            labelList[widget.index],
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
            // diet labels
            Container(
              constraints: const BoxConstraints(
                  minWidth: 320, maxWidth: 320, minHeight: 45),
              child: Card(
                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      dietList[widget.index].length,
                      (dietIndex) {
                        return Card(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: Text(
                                '  ${dietList[widget.index][dietIndex]}  '));
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Row of Serving and misc cards
            SizedBox(
              width: 320,
              height: 173,
              child: Row(
                children: [
                  // servings and recipe stats
                  SizedBox(
                    width: 155,
                    child: Card(
                      color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          SizedBox(
                            height: 29,
                            child: Text(
                              servingsList[widget.index] > 1
                                  ? '${servingsList[widget.index].toString()} Servings'
                                  : '${servingsList[widget.index].toString()} Serving',
                              //${servingsList[widget.index].toString()} Servings
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Divider(),
                          const Text('Per Serving: \n'),
                          Text(' ${calorieList[widget.index]} '),
                          Text(' ${proteinList[widget.index]} '),
                          Text(' ${fatList[widget.index]} '),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 155,
                    child: Card(
                      color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                      child: Column(
                        children: [
                          SizedBox(height: 10),

                          // Source Url Button
                          SizedBox(
                            height: 29,
                            child: FilledButton(
                              onPressed: () async {
                                final Uri url =
                                    Uri.parse(sourceUrlList[widget.index]);
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              style: ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.all(10)),
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                              ),
                              child: Text(
                                sourceNameList[widget.index],
                                style: TextStyle(height: 0.5),
                              ),
                            ),
                          ),
                          Divider(),
                          Spacer(),
                          Text('Time To Cook: ${timeList[widget.index]}m'),
                          Spacer(),
                          Text('Health Score: ${healthList[widget.index]}'),
                          Spacer(),
                          Text(
                              'Total Ingredients: ${ingredientsList[widget.index].length}'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            const Divider(),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 30),
            ),
            IngredientCard(recipeIndex: widget.index),
            const Text(
              'Equipment',
              style: TextStyle(fontSize: 30),
            ),
            EquipmentCard(recipeIndex: widget.index),
            SizedBox(height: 15),
            const Divider(),
            const Text(
              'Instructions',
              style: TextStyle(fontSize: 30),
            ),
            for (var map in recipeStepsList[widget.index])
              InstructionCard(index: widget.index, map: map),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class InstructionCard extends StatelessWidget {
  final int index;
  var map;
  InstructionCard({required this.index, required this.map, super.key});

  @override
  Widget build(BuildContext context) {
    String instructionLabel = '';
    // make instructionLabel everything after last period
    if (map.keys.first.isNotEmpty) {
      instructionLabel = map.keys.first;
      int lastPeriodIndex =
          instructionLabel.lastIndexOf('.'); // Find the last period
      if (lastPeriodIndex != -1) {
        instructionLabel = instructionLabel
            .substring(lastPeriodIndex + 1)
            .trim(); // Extract everything after the last period
      } else {
        instructionLabel = instructionLabel
            .trim(); // Keep the original string if no period is found
      }
    }

    print(instructionLabel); // Output the extracted string

    return Container(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            if (recipeStepsList[index].length > 1) ...[
              Text(
                map.keys.first.isNotEmpty
                    ? '$instructionLabel:'
                    : 'First Instruction:',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const Divider(),
            ],
            const SizedBox(height: 10),
            for (var step in map.values.first)
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 5),
                      child: Card(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            step.description,
                            maxLines: 100,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.onTertiary,
                      child: Text(' ${step.number} '),
                    )
                  ],
                ),
              ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final int recipeIndex;

  const IngredientCard({required this.recipeIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      width: 320,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: List.generate(ingredientsList[recipeIndex].length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Text(
                  ' ${StringUtils.capitalize(ingredientsList[recipeIndex][index], allWords: true)}    ',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class EquipmentCard extends StatelessWidget {
  final int recipeIndex;
  const EquipmentCard({required this.recipeIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minWidth: 320, maxWidth: 320, minHeight: 45),
      width: 320,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: List.generate(equipmentList[recipeIndex].length, (index) {
              return Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Text(
                      '  ${StringUtils.capitalize(equipmentList[recipeIndex][index], allWords: true)}  '));
            }),
          ),
        ),
      ),
    );
  }
}
