import 'package:flutter/material.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/clear_filters_indicator.dart';
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';

import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class IngredientsInput extends StatefulWidget {
  final Map<String, RequireExclude>? givenIngredients;
  final void Function(
    String oldName,
    String newName,
    RequireExclude value,
  ) updateName;
  final void Function(String name, RequireExclude oldValue) updateValue;
  final void Function() addIngredient;
  final void Function(String name) removeIngredient;
  const IngredientsInput({
    required this.removeIngredient,
    required this.addIngredient,
    required this.updateValue,
    required this.updateName,
    this.givenIngredients,
    super.key,
  });
  @override
  State<IngredientsInput> createState() => _IngredientsInputState();
}

class _IngredientsInputState extends State<IngredientsInput> {
  @override
  Widget build(BuildContext context) {
    bool isModified() {
      final values = widget.givenIngredients;

      if (values != null && values.isNotEmpty) {
        if (values.keys.first.isNotEmpty) {
          return true;
        }
      } else {
        return false;
      }

      return false;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
        // Title
        title: Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge!,
          textAlign: TextAlign.center,
        ),
        subtitle: ClearFiltersIndicator(isModified: isModified()),
        tilePadding: EdgeInsets.only(right: 16, left: 63),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enableFeedback: true,
        showTrailingIcon: true,
        collapsedBackgroundColor:
            Theme.of(context).colorScheme.onSecondaryFixed,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        expandedAlignment: Alignment.center,
        children: [
          // Require/Exclude Button
          // TODO maybe make this a search bar with a link to the top 1000 used Ingredients?
          FilledButton.icon(
            onPressed: () => widget.addIngredient(),
            label: const Icon(Icons.add),
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll<Color>(
                Colors.green,
              ),
              iconSize: WidgetStatePropertyAll<double>(30),
              backgroundColor:
                  WidgetStatePropertyAll<Color>(Colors.green.withAlpha(115)),
            ),
          ),
          const SizedBox(height: 10),

          Center(
            child: Column(
              spacing: 10,
              children:
                  //_ingredientsFields.map((field) => field.widget).toList(),
                  widget.givenIngredients!.entries.map(
                (entry) {
                  int index = widget.givenIngredients!.entries
                      .toList()
                      .indexWhere((indexEntry) => indexEntry.key == entry.key);
                  return IngredientRow(
                    removeIngredient: widget.removeIngredient,
                    updateValue: widget.updateValue,
                    updateName: widget.updateName,
                    number: index + 1,
                    initialValue: entry.value,
                    initialText: entry.key,
                    key: Key(entry.key),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class RequireExcludeButton extends StatefulWidget {
  final RequireExclude selectedRequireExcludeMode;
  final Function changeState;
  const RequireExcludeButton({
    required this.selectedRequireExcludeMode,
    required this.changeState,
    super.key,
  });

  @override
  State<RequireExcludeButton> createState() => _RequireExcludeButtonState();
}

class _RequireExcludeButtonState extends State<RequireExcludeButton> {
  @override
  Widget build(BuildContext context) {
    RequireExclude selectedRequireExcludeModeState =
        widget.selectedRequireExcludeMode;
    return SegmentedButton<RequireExclude>(
      direction: Axis.vertical,
      showSelectedIcon: false,
      segments: const <ButtonSegment<RequireExclude>>[
        ButtonSegment(
          label: Text('Require'),
          value: RequireExclude.require,
        ),
        ButtonSegment(
          label: Text('Exclude'),
          value: RequireExclude.exclude,
        ),
      ],
      selected: ({selectedRequireExcludeModeState}),
      onSelectionChanged: (newSelection) {
        widget.changeState(newSelection.first);
      },
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity(horizontal: -3, vertical: -3),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(4), // Adjust to 0 for perfect squares
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primaryContainer;
            }
            return Theme.of(context).colorScheme.onSecondary; // Default color
          },
        ),
      ),
    );
  }
}

class IngredientRow extends StatefulWidget {
  final int number;
  final RequireExclude initialValue;
  final String initialText;
  final void Function(
    String newName,
    String oldName,
    RequireExclude value,
  ) updateName;
  final void Function(String name) removeIngredient;
  final void Function(String name, RequireExclude newValue) updateValue;

  const IngredientRow({
    Key? key,
    required this.updateValue,
    required this.removeIngredient,
    required this.updateName,
    required this.number,
    required this.initialValue,
    required this.initialText,
  }) : super(key: key);

  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  late TextEditingController textFieldController;
  late RequireExclude value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    textFieldController = TextEditingController(text: widget.initialText);
  }

  void changeRequireExcludeMode(RequireExclude newValue) {
    setState(() {
      value = newValue;
    });
    widget.updateValue(widget.initialText, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RequireExcludeButton(
          selectedRequireExcludeMode: value,
          changeState: changeRequireExcludeMode,
        ),
        const SizedBox(width: 5),
        SizedBox(
          key: Key(widget.number.toString()),
          width: 150,
          child: TextField(
            controller: textFieldController,
            onSubmitted: (text) => widget.updateName(
              widget.initialText,
              text,
              value,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Ingredient ${widget.number}',
            ),
          ),
        ),
        // Remove IngredientRow
        IconButton.outlined(
          onPressed: () => widget.removeIngredient(widget.initialText),
          icon: Icon(Icons.remove_rounded, color: Colors.redAccent),
        ),
      ],
    );
  }
}
