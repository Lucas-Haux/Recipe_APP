import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const SettingsGroup({required this.label, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          labelStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
