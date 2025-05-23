import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

void main() async {
  //timeDilation = 10.0;

  Logger.root.level = Level.ALL;

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
