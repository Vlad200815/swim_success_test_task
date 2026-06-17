import 'package:flutter/material.dart';
import 'package:swim_success_test_task/app/config.dart';
import 'package:swim_success_test_task/app/navigation.dart';

class SwimSuccessTestTaskApp extends StatelessWidget {
  const SwimSuccessTestTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Navigation.router(),
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}
