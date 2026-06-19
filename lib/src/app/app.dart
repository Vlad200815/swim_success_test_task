import 'package:flutter/material.dart';
import 'package:swim_success_test_task/src/app/config.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/core/resource/theme.dart';

class SwimSuccessTestTaskApp extends StatelessWidget {
  const SwimSuccessTestTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Navigation.router(),
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    );
  }
}
