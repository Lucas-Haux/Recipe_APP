import 'package:flutter/material.dart';

class SettingsParameter extends StatefulWidget {
  final String label;
  const SettingsParameter({required this.label, super.key});

  @override
  State<SettingsParameter> createState() => _SettingsParameterState();
}

class _SettingsParameterState extends State<SettingsParameter> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(widget.label),
          Spacer(),
          Switch(
            value: enabled,
            onChanged: (value) => setState(() {
              enabled = !enabled;
            }),
          ),
        ],
      ),
    );
  }
}
