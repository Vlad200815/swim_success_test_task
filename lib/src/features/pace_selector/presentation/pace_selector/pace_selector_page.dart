import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/app/navigation.dart';
import 'package:swim_success_test_task/core/resource/theme_dimen.dart';
import 'package:swim_success_test_task/features/pace_selector/presentation/widgets/time_input.dart';

class PaceSelectorPage extends StatelessWidget {
  const PaceSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Dimen.defaultHorizontalPadding,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      "What's your fastest 100m freestyle?",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "This helps us build a more accurate plan for you.",
                      style: textTheme.bodyMedium,
                    ),
                    const Spacer(flex: 2),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("YOUR PACE", style: textTheme.labelLarge),
                          const SizedBox(height: 16),
                          TimeInput(onChanged: (value) {}),
                          const SizedBox(height: 10),
                          Text(
                            "MIN  :  SEC  /  100M",
                            style: textTheme.labelLarge,
                          ),
                          const SizedBox(height: 40),
                          Text("THAT PUTS YOU AT", style: textTheme.bodyMedium),
                          const SizedBox(height: 16),
                          Text("Intermediate", style: textTheme.headlineLarge),
                          const SizedBox(height: 26),
                          Slider(value: 0.3, onChanged: (double value) {}),
                        ],
                      ),
                    ),
                    const Spacer(flex: 3),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Continue ➡️"),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //
  // Navigation
  //
  static const String path = "/pace_selector";
  static const String name = "PaceSelector";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      return PaceSelectorPage();
    });
  }

  static Future<Object?> open(BuildContext context) {
    return context.push(Uri(path: path).toString());
  }
}
