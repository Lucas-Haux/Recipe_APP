import 'package:flutter/material.dart';
import '../../../domain/enums.dart';

class IngredientsInputCard extends StatefulWidget {
  final void Function(String) onChanged;
  final TextStyle titleTextStyle;
  const IngredientsInputCard({
    required this.onChanged,
    required this.titleTextStyle,
    super.key,
  });
  @override
  State<IngredientsInputCard> createState() => _IngredientsInputState();
}

class _IngredientField {
  final int name;
  final Widget widget;
  _IngredientField({required this.name, required this.widget});
}

// TODO make _ingredientsFields = giveingredientsFields from pramaters repo
final List<_IngredientField> _ingredientsFields = [];
int _counter = 1; // To track ingredient numbers

class _IngredientsInputState extends State<IngredientsInputCard> {
  @override
  void initState() {
    super.initState();
    // Add the first ingredient field by default
    if (_ingredientsFields.isEmpty) {
      _addIngredientField();
    }
  }

  void _addIngredientField() {
    int name = _counter;
    setState(() {
      _ingredientsFields.add(
        _IngredientField(
          name: name,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                key: (Key(name.toString())),
                width: 250,
                child: TextField(
                  onChanged: (value) => widget.onChanged(value),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Ingredient ${name.toString()}',
                  ),
                ),
              ),
              IconButton.outlined(
                onPressed: () => _removeIngredientField(name),
                icon: const Icon(Icons.remove, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      );
      _counter++;
    });
  }

  void _removeIngredientField(int key) {
    print(key);
    for (var field in _ingredientsFields) {
      print(field.name);
    }
    setState(() {
      _ingredientsFields.removeWhere((field) => field.name == key);
    });
  }

  @override
  Widget build(BuildContext context) {
    RequireExclude selectedRequireExcludeMode = RequireExclude.require;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
        // Title
        title: Text(
          'Ingredients',
          style: widget.titleTextStyle,
          textAlign: TextAlign.center,
        ),
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
        maintainState: true,
        enableFeedback: true,
        showTrailingIcon: false,
        collapsedBackgroundColor:
            Theme.of(context).colorScheme.onSecondaryFixed,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        expandedAlignment: Alignment.center,
        dense: false,
        children: [
          // Require/Exclude Button
          SegmentedButton<RequireExclude>(
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
            selected: ({selectedRequireExcludeMode}),
            onSelectionChanged: (newSelection) {
              setState(() {
                selectedRequireExcludeMode = newSelection.first;
              });
            },
          ),
          const SizedBox(height: 5),
          // TODO maybe make this a search bar with a link to the top 1000 used Ingredients?
          FilledButton.icon(
            onPressed: () => _addIngredientField(),
            label: const Icon(Icons.add),
          ),

          Center(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children:
                  _ingredientsFields.map((field) => field.widget).toList(),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
