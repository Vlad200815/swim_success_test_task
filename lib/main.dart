import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swim_success_test_task/src/app/app.dart';
import 'package:swim_success_test_task/src/core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// DI
  Di.setup();

  runApp(const SwimSuccessTestTaskApp());
}
