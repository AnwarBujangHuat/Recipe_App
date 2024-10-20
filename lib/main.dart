import 'package:flutter/material.dart';

import 'src/apps/app.dart';
import 'src/features/settings/settings_controller.dart';
import 'src/features/settings/settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
}
