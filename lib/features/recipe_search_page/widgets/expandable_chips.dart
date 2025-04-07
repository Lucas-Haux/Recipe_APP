import 'package:flutter/material.dart';
import 'package:recipe_box/features/recipe_search_page/widgets/clear_filters_indicator.dart';

import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/functions/capitalize_string.dart';

enum ChipMode { requireExclude, and, or, orAnd }

class ExpandableChipsCard<RecipeParameter extends DisplayableEnum,
    ParameterValue extends ChipParametersMode> extends StatefulWidget {
  final ChipMode chipMode;
  final String title;
  // shouldnt need this any more
  final Map<RecipeParameter, ChipParametersMode> givenEnums;
  final void Function(Map<String, dynamic>) updateState;
  final AndOrType? defualtAndOr;

  const ExpandableChipsCard({
    required this.chipMode,
    required this.title,
    required this.givenEnums,
    required this.updateState,
    this.defualtAndOr,
    super.key,
  });

  @override
  ExpandableChipsState<RecipeParameter, ParameterValue> createState() =>
      ExpandableChipsState<RecipeParameter, ParameterValue>();
}

class ExpandableChipsState<RecipeParameter extends DisplayableEnum,
        ParameterValue extends ChipParametersMode>
    extends State<ExpandableChipsCard<RecipeParameter, ParameterValue>> {
  // defaults
  RequireExclude selectedRequireExcludeMode = RequireExclude.require;
  AndOrType selectedAndOr = AndOrType.and;

  @override
  Widget build(BuildContext context) {
    final List<RecipeParameter> enumValues = widget.givenEnums.keys.toList();

    ButtonStyle segmentedButtonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context).colorScheme.primaryContainer;
          }
          return Theme.of(context).colorScheme.onSecondary; // Default color
        },
      ),
    );

    bool isModified() {
      final values = widget.givenEnums.values.toSet();

      if (values.contains(RequireExclude.require) ||
          values.contains(RequireExclude.exclude) ||
          values.contains(AndOrType.and) ||
          values.contains(AndOrType.or)) {
        return true;
      } else {
        return false;
      }
    }

    // Change button Text color based on value
    Color getTextColor(RecipeParameter value) {
      final dataBaseValue = widget.givenEnums[value];
      if (dataBaseValue == RequireExclude.require ||
          dataBaseValue == AndOrType.and) {
        return Colors.green;
      } else if (dataBaseValue == RequireExclude.exclude) {
        return Colors.red;
      } else if (dataBaseValue == AndOrType.or) {
        return Colors.blue;
      } else {
        // TODO use system text color?
        return Colors.white;
      }
    }

    // Change button background color based on value
    Color getBGColor(RecipeParameter value) {
      final textColor = getTextColor(value);
      if (textColor == Colors.white) {
        return Theme.of(context).colorScheme.tertiaryContainer;
      } else {
        return textColor.withAlpha(115); // return the same as text but darker
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!,
          textAlign: TextAlign.center,
        ),
        subtitle: ClearFiltersIndicator(isModified: isModified()),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        maintainState: true,
        enableFeedback: true,
        showTrailingIcon: true,
        tilePadding: EdgeInsets.only(right: 16, left: 63),
        collapsedBackgroundColor:
            Theme.of(context).colorScheme.onSecondaryFixed,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        expandedAlignment: Alignment.center,
        dense: false,
        children: [
          // RequireExclude SegmentedButton
          if (widget.chipMode == ChipMode.requireExclude)
            SegmentedButton<RequireExclude>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<RequireExclude>>[
                ButtonSegment(
                  label: Text('Require'),
                  value: RequireExclude.require,
                  tooltip:
                      'Requires Selected Options to be in Every Recipe Result',
                ),
                ButtonSegment(
                  label: Text('Exclude'),
                  value: RequireExclude.exclude,
                  tooltip: 'Excludes Selected Options in Every Recipe Result',
                ),
              ],
              selected: ({selectedRequireExcludeMode}),
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedRequireExcludeMode = newSelection.first;
                });
              },
              style: segmentedButtonStyle,
            ),

          // And Or SegmentedButton
          if (widget.chipMode == ChipMode.orAnd)
            SegmentedButton<AndOrType>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<AndOrType>>[
                ButtonSegment(
                  label: Text('And'),
                  value: AndOrType.and,
                ),
                ButtonSegment(
                  label: Text('Or'),
                  value: AndOrType.or,
                ),
              ],
              selected: ({selectedAndOr}),
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedAndOr = newSelection.first;
                });
                // makes it so chip buttons cant be `and` and `or` at the same time
                final dataBaseEnums = widget.givenEnums;
                for (var recipeParameter in widget.givenEnums.keys) {
                  if (dataBaseEnums[recipeParameter] != AndOrType.unspecified &&
                      dataBaseEnums[recipeParameter] != selectedAndOr) {
                    widget.updateState({
                      widget.title: {recipeParameter: selectedAndOr}
                    });
                  }
                }
                // widget.updateState({'selectedAndOr': newSelection.first});
              },
              style: segmentedButtonStyle,
            ),

          // ChoiceChips
          Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, bottom: 7),
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              children: enumValues.map(
                (value) {
                  return ChoiceChip(
                    label: Text(
                      capitalizeString(value.displayName),
                      style: TextStyle(
                        color: getTextColor(value),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    color: WidgetStatePropertyAll(getBGColor(value)),
                    showCheckmark: false,
                    selected: false, //
                    onSelected: (bool selected) {
                      // TODO remove the amount of if statements
                      // if requireExclude
                      final dataBaseValue = widget.givenEnums[value];
                      if (widget.chipMode == ChipMode.requireExclude) {
                        if (dataBaseValue == RequireExclude.unspecified) {
                          widget.updateState({
                            widget.title: {value: selectedRequireExcludeMode}
                          });
                        } else {
                          widget.updateState({
                            widget.title: {value: RequireExclude.unspecified}
                          });
                        }
                      } else
                      // if and or
                      if (widget.chipMode == ChipMode.orAnd) {
                        if (dataBaseValue == AndOrType.unspecified) {
                          widget.updateState({
                            widget.title: {value: selectedAndOr}
                          });
                        } else {
                          widget.updateState({
                            widget.title: {value: AndOrType.unspecified}
                          });
                        }
                      } else
                      // if and
                      if (widget.chipMode == ChipMode.and) {
                        if (dataBaseValue == RequireExclude.unspecified) {
                          widget.updateState({
                            widget.title: {value: RequireExclude.exclude}
                          });
                        } else {
                          widget.updateState({
                            widget.title: {value: RequireExclude.unspecified}
                          });
                        }
                      }
                      if (widget.chipMode == ChipMode.or) {
                        if (dataBaseValue == AndOrType.unspecified) {
                          widget.updateState({
                            widget.title: {value: AndOrType.or}
                          });
                        } else {
                          widget.updateState({
                            widget.title: {value: AndOrType.unspecified}
                          });
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
