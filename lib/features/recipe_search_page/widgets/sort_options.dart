import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/functions/capitalize_string.dart';

class SortOptions extends StatefulWidget {
  final SortType currentSorting;
  final void Function(Map<String, dynamic>) updateState;
  const SortOptions({
    required this.currentSorting,
    required this.updateState,
    super.key,
  });

  @override
  State<SortOptions> createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 30,
            spreadRadius: 00,
            color: Colors.black45,
            //color: Colors.green,
            inset: true,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sort Recipes By:',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white70, fontWeight: FontWeight.w900),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: Wrap(
              spacing: 13,
              alignment: WrapAlignment.center,
              children: List.generate(SortType.values.length, (int index) {
                return _SortChip(
                  sortOption: SortType.values[index],
                  enabled: SortType.values[index] == widget.currentSorting,
                  updateState: widget.updateState,
                );
              }),
            ),
          ),
          //Divider(),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final SortType sortOption;
  final bool enabled;
  final void Function(Map<String, dynamic>) updateState;
  const _SortChip({
    required this.sortOption,
    required this.enabled,
    required this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        capitalizeString(sortOption.displayName),
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
      ),
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      selected: enabled,
      onSelected: (_) => updateState({'Shorting': sortOption}),
    );
  }
}
