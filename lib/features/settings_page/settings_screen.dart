import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/shared/themes/dimens.dart';

import 'widgets/settings_parameter.dart';
import 'widgets/settings_group.dart';

final double itemSpacing = 15;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimensMobile.paddingScreenHorizontal,
              vertical: Dimens.dimensMobile.paddingScreenVertical),
          child: Column(
            spacing: itemSpacing,
            children: [
              Text('Settings'),
              SettingsGroup(
                label: 'Label',
                children: [
                  SettingsParameter(label: 'test'),
                  SettingsParameter(label: 'test'),
                  SettingsParameter(label: 'test'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
