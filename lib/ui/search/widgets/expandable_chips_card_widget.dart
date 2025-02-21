import 'package:flutter/material.dart';
import '../../../domain/enums.dart';

class ExpandableChipsCard<RecipeParameter extends DisplayableEnum,
    ParameterValue extends ChipModeCollection> extends StatefulWidget {
  final ChipMode chipMode;
  final String title;
  // shouldnt need this no more
  final Map<RecipeParameter, ChipModeCollection> givenEnums;
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
        ParameterValue extends ChipModeCollection>
    extends State<ExpandableChipsCard<RecipeParameter, ParameterValue>> {
  RequireExclude selectedRequireExcludeMode = RequireExclude.require;
  AndOrType selectedAndOr = AndOrType.and;

  @override
  Widget build(BuildContext context) {
    final List<RecipeParameter> enumValues = widget.givenEnums.keys.toList();

    TextStyle titleTextStyle = const TextStyle(fontSize: 25);

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
          style: titleTextStyle,
          textAlign: TextAlign.center,
        ),
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
                    tooltip:
                        'Every Recipe Result Requires Every Selected Option'),
                ButtonSegment(
                    label: Text('Or'),
                    value: AndOrType.or,
                    tooltip:
                        'Every Recipe Result Requires at Least One of the Selected Options'),
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
                      value.displayName,
                      style: TextStyle(color: getTextColor(value)),
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
