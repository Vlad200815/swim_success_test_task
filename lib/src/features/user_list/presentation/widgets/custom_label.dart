import 'package:flutter/material.dart';

class CustomLable extends StatelessWidget {
  const CustomLable({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text("Made by Vlad Semeniuk😀", style: textTheme.labelLarge),
      ),
    );
  }
}
