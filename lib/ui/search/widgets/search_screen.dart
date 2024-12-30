import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../domain/enums.dart';
import '../../search_results/widgets/search_results_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_box/ui/home/widgets/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/search_view_model.dart';
import '../../core/ui/search_bar_field_widget.dart';

TextStyle titleTextStyle = const TextStyle(fontSize: 25);

class SearchScreen extends ConsumerWidget {
  final TextEditingController searchController;
  const SearchScreen({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchViewModel = SearchViewModel(ref);

    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
        textEditingController: searchController,
        updateQuery: searchViewModel.setQuery,
        searchForRecipes: searchViewModel.searchForRecipes,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            pinned: true,
            snap: false,
            expandedHeight: 180.0,
            leading: const SizedBox(), // hide backbutton in bar
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              background: const Center(
                child: Text(
                  'Search For A Recipe!',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              titlePadding: const EdgeInsets.only(), // removes left padding
              title: Container(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 8.0),
                height: 70,

                // Search Field
                child: Hero(
                  tag: 'SearchBar',
                  child: SearchBarFieldWidget(
                    key: const ValueKey('homePageSearch'),
                    goToSearchPage: false,
                    controller: searchController,
                    autofocus: true,
                    readOnly: false,
                    onTap: null,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            key: const Key('SearchParameters'),
            child: Column(
              children: [
                const SizedBox(height: 15),
                // Cuisines
                _ExpandableChips(
                  chipMode: ChipMode.requireExclude,
                  title: 'Cuisines',
                  enumValues: CuisineType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.selectedCuisines,
                  givenDeselectedEnums:
                      searchViewModel.searchParameters.deselectedCuisines,
                  updateSelectedEnums: searchViewModel.setSelectedCuisines,
                  updateDeselectedEnums: searchViewModel.setDeselectedCuisines,
                ),
                // Diets
                _ExpandableChips(
                  chipMode: ChipMode.orAnd,
                  updateAndOr: searchViewModel.setDietAndOr,
                  defualtAndOr: searchViewModel.searchParameters.dietAndOr,
                  title: 'Diets',
                  enumValues: DietType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.requiredDiets,
                  updateSelectedEnums: searchViewModel.setRequiredDiets,
                ),
                // Intolerances
                _ExpandableChips(
                  chipMode: ChipMode.and,
                  title: 'Intolerances',
                  enumValues: IntoleranceType.values.toList(),
                  givenSelectedEnums:
                      searchViewModel.searchParameters.intolerances,
                  updateSelectedEnums: searchViewModel.setIntolerance,
                ),
                // Ingredients
                _IngredientsInput(
                  onChanged: (String test) {
                    // Your implementation here
                    print(test); // Example action
                  },
                ),
                // Max Ready Time
                const _MaxReadyTime(
                  givenPrimarySliderValue: 60,
                  primaryTitle: 'Max Ready Time',
                ),

                // Servings
                const _MinMaxSliders(
                  title: 'Servings',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                ),

                // Carbs
                const _MinMaxSliders(
                  title: 'Carbs',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                ),

                // Servings
                const _MinMaxSliders(
                  title: 'Protein',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                ),

                // Servings
                const _MinMaxSliders(
                  title: 'Fat',
                  givenMaxValue: 100,
                  givenMinValue: 10,
                ),
                const SizedBox(height: 120),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  final void Function(String) updateQuery;
  final VoidCallback searchForRecipes;
  final TextEditingController textEditingController;
  const _FloatingActionButtons({
    required this.updateQuery,
    required this.searchForRecipes,
    required this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          // Home
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 63.0),
            child: FloatingActionButton.small(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.home),
              onPressed: () {
                print('go home');
                context.go('/');
              },
            ),
          ),
          //Search
          FloatingActionButton.extended(
            heroTag: 'SearchButton',
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              updateQuery(textEditingController.text);
              // SearchViewModel().searchForRecipes(searchController.text.trim());

              context.go('/search_results');
            },
            icon: const Icon(Icons.search),
            extendedPadding: const EdgeInsets.only(left: 15, right: 15),
            label: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

enum RequireExclude { require, exclude }

enum ChipMode { requireExclude, and, orAnd }

class _ExpandableChips<T extends DisplayableEnum> extends StatefulWidget {
  final ChipMode chipMode;
  final String title;
  final List<T> enumValues;
  final Set<T> givenSelectedEnums;
  final Set<T>? givenDeselectedEnums;
  final void Function(T) updateSelectedEnums;
  final void Function(T)? updateDeselectedEnums;
  final AndOrType? defualtAndOr;
  final void Function(AndOrType)? updateAndOr;
  const _ExpandableChips({
    required this.chipMode,
    required this.title,
    required this.enumValues,
    required this.givenSelectedEnums,
    this.givenDeselectedEnums,
    required this.updateSelectedEnums,
    this.updateDeselectedEnums,
    this.defualtAndOr,
    this.updateAndOr,
  });

  @override
  _ExpandableChipsState<T> createState() => _ExpandableChipsState<T>();
}

class _ExpandableChipsState<T extends DisplayableEnum>
    extends State<_ExpandableChips<T>> {
  RequireExclude selectedRequireExcludeMode = RequireExclude.require;

  @override
  Widget build(BuildContext context) {
    Set<T> selectedEnums = widget.givenSelectedEnums; // Tracks chips
    Set<T> deselectedEnums = {};
    if (widget.chipMode == ChipMode.requireExclude) {
      deselectedEnums = widget.givenDeselectedEnums!; // Tracks chips
    }
    AndOrType? selectedAndOr;
    if (widget.chipMode == ChipMode.orAnd) {
      selectedAndOr = widget.defualtAndOr!;
    }

    Color getTextColor(T value) {
      if (selectedEnums.contains(value)) {
        return Colors.green;
      } else if (deselectedEnums.contains(value)) {
        return Colors.red;
      } else {
        return Colors.white;
      }
    }

    Color getBGColor(T value) {
      if (selectedEnums.contains(value)) {
        return Colors.green.withOpacity(0.5);
      } else if (deselectedEnums.contains(value)) {
        return Colors.red.withOpacity(0.5);
      } else {
        return Theme.of(context).colorScheme.tertiaryContainer;
      }
    }

    void requireExcludeOnSelect(T value) {
      if (selectedRequireExcludeMode == RequireExclude.require) {
        // Update list of selectedEnums
        setState(() {
          widget.updateSelectedEnums(value);
        });
        // Change state of the chip
        if (selectedEnums.contains(value)) {
          selectedEnums.remove(value);
        } else if (deselectedEnums.contains(value)) {
          deselectedEnums.remove(value);
        } else {
          selectedEnums.add(value);
        }
      } else if (selectedRequireExcludeMode == RequireExclude.exclude) {
        // Update list of deselectedEnums
        setState(() {
          widget.updateDeselectedEnums!(value);
        });
        // Change state of the chip
        if (deselectedEnums.contains(value)) {
          deselectedEnums.remove(value);
        } else if (selectedEnums.contains(value)) {
          selectedEnums.remove(value);
        } else {
          deselectedEnums.add(value);
        }
      }
    }

    TextStyle titleTextStyle = const TextStyle(fontSize: 25);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: titleTextStyle,
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
          // Require Exclude Button
          if (widget.chipMode == ChipMode.requireExclude)
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

          // And Or Button
          if (widget.chipMode == ChipMode.orAnd)
            SegmentedButton<AndOrType>(
              segments: const <ButtonSegment<AndOrType>>[
                ButtonSegment(label: Text('And'), value: AndOrType.and),
                ButtonSegment(label: Text('Or'), value: AndOrType.or),
              ],
              selected: ({selectedAndOr!}),
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedAndOr = newSelection.first;
                });
                widget.updateAndOr!(newSelection.first);
              },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              children: widget.enumValues.map(
                (value) {
                  return ChoiceChip(
                    label: Text(
                      value.displayName,
                      style: TextStyle(color: getTextColor(value)),
                    ),
                    color: WidgetStatePropertyAll(getBGColor(value)),
                    showCheckmark: false,
                    selected: selectedEnums.contains(value) ||
                        deselectedEnums.contains(value),
                    onSelected: (bool selected) {
                      if (widget.chipMode == ChipMode.requireExclude) {
                        requireExcludeOnSelect(value);
                      } else {
                        setState(() {
                          widget.updateSelectedEnums(value);
                        });
                        if (selectedEnums.contains(value)) {
                          selectedEnums.remove(value);
                        } else {
                          selectedEnums.add(value);
                        }
                      }
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientsInput extends StatefulWidget {
  final void Function(String) onChanged;
  const _IngredientsInput({required this.onChanged});

  @override
  State<_IngredientsInput> createState() => _IngredientsInputState();
}

class _IngredientField {
  final int name;
  final Widget widget;

  _IngredientField({required this.name, required this.widget});
}

// TODO make _ingredientsFields = giveingredientsFields from pramaters repo
final List<_IngredientField> _ingredientsFields = [];
int _counter = 1; // To track ingredient numbers

class _IngredientsInputState extends State<_IngredientsInput> {
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
        title: Text(
          'Ingredients',
          style: titleTextStyle,
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

class _MaxReadyTime extends StatefulWidget {
  final double givenPrimarySliderValue;
  final String primaryTitle;
  const _MaxReadyTime(
      {required this.givenPrimarySliderValue, required this.primaryTitle});

  @override
  State<_MaxReadyTime> createState() => _MaxReadyTimeState();
}

class _MaxReadyTimeState extends State<_MaxReadyTime> {
  late double _primarySliderValue;

  @override
  void initState() {
    super.initState();
    _primarySliderValue = widget.givenPrimarySliderValue; // Initialize state
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(widget.primaryTitle, style: titleTextStyle),
          Slider(
            value: _primarySliderValue,
            min: 30,
            max: 720,
            divisions: 360,
            label: minutesToHourMin(_primarySliderValue.round()),
            onChanged: (double value) {
              setState(() {
                double remainder = value.round() % 30;
                _primarySliderValue = value.round() - remainder;
              });
            },
          ),
        ],
      ),
    );
  }

  String minutesToHourMin(int value) {
    int hours, minutes, remainder;
    hours = value ~/ 60;
    remainder = value % 60;

    if (remainder >= 30) {
      minutes = 30;
    } else {
      minutes = 0;
    }

    String result = "${hours}h:${minutes}m";
    return result;
  }
}

class _MinMaxSliders extends StatefulWidget {
  final String title;
  final double givenMaxValue;
  final double givenMinValue;
  const _MinMaxSliders({
    required this.title,
    required this.givenMaxValue,
    required this.givenMinValue,
  });

  @override
  State<_MinMaxSliders> createState() => _MinMaxSlidersState();
}

class _MinMaxSlidersState extends State<_MinMaxSliders> {
  late double _maxSliderValue;
  late double _minSliderValue;

  @override
  void initState() {
    super.initState();
    _maxSliderValue = widget.givenMaxValue; // Initialize state
    _minSliderValue = widget.givenMinValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text('Min ${widget.title}', style: titleTextStyle),
          Slider(
            value: _minSliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            secondaryTrackValue: _maxSliderValue,
            label: _minSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _minSliderValue = value.round().toDouble();
              });
            },
          ),
          Text('Max ${widget.title}', style: titleTextStyle),
          Slider(
            value: _maxSliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            secondaryTrackValue: _minSliderValue,
            label: _maxSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _maxSliderValue = value.round().toDouble();
              });
            },
          ),
        ],
      ),
    );
  }
}
