import 'package:flutter/material.dart';
import 'package:swim_success_test_task/src/core/resource/theme_colors.dart';

/// Pace indicator: a row of labels, an animated track + thumb, optional
/// tick marks on the track, and optional small time labels beneath each
/// tick. Draggable — reports changes via [onChanged]. Convention: left =
/// 0.0, right = 1.0.
///
/// [tickLabels], if provided, should be the same length as [tickPositions]
/// — index i labels the tick at tickPositions[i]. Stays purely text-based;
/// PaceSlider has no concept of "seconds" or any other unit, the caller
/// decides what the labels say.
class PaceSlider extends StatelessWidget {
  final List<String> labels;
  final int activeIndex;
  final double value;
  final ValueChanged<double>? onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final List<double> tickPositions;
  final List<String> tickLabels;

  const PaceSlider({
    super.key,
    required this.labels,
    required this.activeIndex,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor = const Color(0xFF3A3D45),
    this.tickPositions = const [],
    this.tickLabels = const [],
  });

  void _updateFromLocalPosition(double dx, double trackWidth) {
    if (onChanged == null) return;
    final newValue = (dx / trackWidth).clamp(0.0, 1.0);
    onChanged!(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = activeColor ?? ThemeColors.primary;
    const animationDuration = Duration(milliseconds: 200);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < labels.length; i++)
              AnimatedDefaultTextStyle(
                duration: animationDuration,
                style: TextStyle(
                  color: i == activeIndex ? fillColor : Colors.white54,
                  fontWeight: i == activeIndex
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 13,
                ),
                child: Text(labels[i]),
              ),
          ],
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            const thumbSize = 28.0;
            const tapTargetHeight = 40.0;
            const tickWidth = 3.0;
            const tickHeight =
                8.0; // taller — reads as a guide line, not just a dot
            final trackWidth = constraints.maxWidth;
            final fillWidth = trackWidth * value.clamp(0.0, 1.0);
            final thumbLeft = (fillWidth - thumbSize / 2).clamp(
              0.0,
              trackWidth - thumbSize,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) => _updateFromLocalPosition(
                    details.localPosition.dx,
                    trackWidth,
                  ),
                  onHorizontalDragUpdate: (details) => _updateFromLocalPosition(
                    details.localPosition.dx,
                    trackWidth,
                  ),
                  child: SizedBox(
                    height: tapTargetHeight,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: inactiveColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        AnimatedContainer(
                          duration: animationDuration,
                          curve: Curves.easeOut,
                          height: 4,
                          width: fillWidth,
                          decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        for (final pos in tickPositions)
                          Positioned(
                            left:
                                trackWidth * pos.clamp(0.0, 1.0) -
                                tickWidth / 2,
                            child: Container(
                              width: tickWidth,
                              height: tickHeight,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(
                                  tickWidth / 2,
                                ),
                              ),
                            ),
                          ),
                        AnimatedPositioned(
                          duration: animationDuration,
                          curve: Curves.easeOut,
                          left: thumbLeft,
                          child: AnimatedContainer(
                            duration: animationDuration,
                            curve: Curves.easeOut,
                            width: thumbSize,
                            height: thumbSize,
                            decoration: BoxDecoration(
                              color: fillColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (tickPositions.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 16,
                    child: Stack(
                      children: [
                        for (var i = 0; i < tickPositions.length; i++)
                          Positioned(
                            left:
                                trackWidth * tickPositions[i].clamp(0.0, 1.0) -
                                14,
                            child: Text(
                              i < tickLabels.length ? tickLabels[i] : '',
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
