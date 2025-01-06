import 'package:flutter/material.dart';
import '../../../domain/enums.dart';

class ExpandableChipsCard<T extends DisplayableEnum> extends StatefulWidget {
  final ChipMode chipMode;
  final String title;
  final List<T> enumValues;
  final Set<T> givenSelectedEnums;
  final Set<T>? givenDeselectedEnums;
  final void Function(T) updateSelectedEnums;
  final void Function(T)? updateDeselectedEnums;
  final AndOrType? defualtAndOr;
  final void Function(AndOrType)? updateAndOr;
  const ExpandableChipsCard({
    required this.chipMode,
    required this.title,
    required this.enumValues,
    required this.givenSelectedEnums,
    this.givenDeselectedEnums,
    required this.updateSelectedEnums,
    this.updateDeselectedEnums,
    this.defualtAndOr,
    this.updateAndOr,
    super.key,
  });

  @override
  ExpandableChipsState<T> createState() => ExpandableChipsState<T>();
}

class ExpandableChipsState<T extends DisplayableEnum>
    extends State<ExpandableChipsCard<T>> {
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
