import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/app/config.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/core/resource/theme_dimen.dart';
import 'package:swim_success_test_task/src/features/pace_selector/presentation/pace_selector/cubit/pace_selector_cubit.dart';
import 'package:swim_success_test_task/src/features/pace_selector/presentation/widgets/pace_slider.dart';
import 'package:swim_success_test_task/src/features/pace_selector/presentation/widgets/time_input.dart';

import '../../../../core/extension/extensions.dart';

class PaceSelectorPage extends StatelessWidget {
  const PaceSelectorPage({super.key});

  double _gap(
    double screenHeight,
    double fraction, {
    double min = 8,
    double max = 64,
  }) {
    return (screenHeight * fraction).clamp(min, max).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimen.defaultHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _gap(screenHeight, 0.045, min: 32, max: 48)),
              Text(
                "What's your fastest 100m freestyle?",
                style: textTheme.headlineLarge,
              ),
              SizedBox(height: _gap(screenHeight, 0.022, min: 16, max: 24)),
              Text(
                "This helps us build a more accurate plan for you.",
                style: textTheme.bodyMedium,
              ),
              SizedBox(height: _gap(screenHeight, 0.05, min: 24, max: 56)),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("YOUR PACE", style: textTheme.labelLarge),
                    SizedBox(
                      height: _gap(screenHeight, 0.018, min: 12, max: 20),
                    ),
                    BlocBuilder<PaceSelectorCubit, PaceSelectorState>(
                      builder: (context, state) {
                        return TimeInput(
                          initialDuration: state.time,
                          onChanged: (duration) => context
                              .read<PaceSelectorCubit>()
                              .updateTime(duration),
                        );
                      },
                    ),
                    SizedBox(
                      height: _gap(screenHeight, 0.012, min: 8, max: 14),
                    ),
                    Text("MIN  :  SEC  /  100M", style: textTheme.labelLarge),
                    SizedBox(
                      height: _gap(screenHeight, 0.045, min: 32, max: 48),
                    ),
                    Text("THAT PUTS YOU AT", style: textTheme.bodyMedium),
                    SizedBox(
                      height: _gap(screenHeight, 0.018, min: 12, max: 20),
                    ),
                    BlocBuilder<PaceSelectorCubit, PaceSelectorState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style:
                                  (textTheme.headlineLarge ?? const TextStyle())
                                      .copyWith(color: state.level.color),
                              child: Text(state.level.label),
                            ),
                            SizedBox(
                              height: _gap(
                                screenHeight,
                                0.026,
                                min: 16,
                                max: 28,
                              ),
                            ),
                            PaceSlider(
                              labels: [
                                PaceLevel.elite.label,
                                PaceLevel.advanced.label,
                                PaceLevel.intermediate.label,
                                PaceLevel.beginner.label,
                              ],
                              activeIndex: state.level.displayIndex,
                              value: state.sliderValue,
                              activeColor: state.level.color,
                              tickPositions: PaceSelectorCubit
                                  .levelBoundarySeconds
                                  .map(PaceSelectorCubit.secondsToValue)
                                  .toList(),
                              tickLabels: PaceSelectorCubit.levelBoundarySeconds
                                  .map(PaceSelectorCubit.formatSeconds)
                                  .toList(),
                              onChanged: (value) => context
                                  .read<PaceSelectorCubit>()
                                  .setFromSliderValue(value),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: _gap(screenHeight, 0.07, min: 40, max: 72)),
              BlocBuilder<PaceSelectorCubit, PaceSelectorState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.level.color,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Continue ➡️"),
                  );
                },
              ),
              SizedBox(height: _gap(screenHeight, 0.045, min: 32, max: 48)),
            ],
          ),
        ),
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
      return BlocProvider(
        create: (_) => PaceSelectorCubit(),
        child: const PaceSelectorPage(),
      );
    });
  }

  static Future<Object?> open(BuildContext context) {
    return context.push(Uri(path: path).toString());
  }
}
