import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swim_success_test_task/gen/assets.gen.dart';
import 'package:swim_success_test_task/src/core/resource/theme_colors.dart';

class TimeInput extends StatefulWidget {
  final Duration? initialDuration;
  final ValueChanged<Duration> onChanged;

  const TimeInput({super.key, this.initialDuration, required this.onChanged});

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  late final _minutesCtrl = TextEditingController(
    text: (widget.initialDuration?.inMinutes ?? 0).toString().padLeft(2, '0'),
  );
  late final _secondsCtrl = TextEditingController(
    text: ((widget.initialDuration?.inSeconds ?? 0) % 60).toString().padLeft(
      2,
      '0',
    ),
  );

  final _minutesFocus = FocusNode();
  final _secondsFocus = FocusNode();

  bool _isExternalSync = false;

  @override
  void initState() {
    super.initState();

    for (final (focus, ctrl) in [
      (_minutesFocus, _minutesCtrl),
      (_secondsFocus, _secondsCtrl),
    ]) {
      focus.addListener(() {
        if (focus.hasFocus) {
          ctrl.selection = TextSelection(
            baseOffset: 0,
            extentOffset: ctrl.text.length,
          );
        }
      });
    }

    _secondsFocus.addListener(() {
      if (!_secondsFocus.hasFocus) {
        final value = int.tryParse(_secondsCtrl.text) ?? 0;
        final clamped = value.clamp(0, 59);
        _secondsCtrl.text = clamped.toString().padLeft(2, '0');
        _emit();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final incoming = widget.initialDuration;
    if (incoming == null) return;
    if (incoming == oldWidget.initialDuration) return;
    if (_minutesFocus.hasFocus || _secondsFocus.hasFocus) return;

    final minutesText = incoming.inMinutes.toString().padLeft(2, '0');
    final secondsText = (incoming.inSeconds % 60).toString().padLeft(2, '0');

    if (_minutesCtrl.text == minutesText && _secondsCtrl.text == secondsText) {
      return;
    }

    _isExternalSync = true;
    _minutesCtrl.text = minutesText;
    _secondsCtrl.text = secondsText;
    _isExternalSync = false;
  }

  void _emit() {
    final minutes = int.tryParse(_minutesCtrl.text) ?? 0;
    final seconds = int.tryParse(_secondsCtrl.text) ?? 0;
    widget.onChanged(Duration(minutes: minutes, seconds: seconds));
  }

  void _step(TextEditingController ctrl, int delta, {required int max}) {
    final current = int.tryParse(ctrl.text) ?? 0;
    final next = (current + delta).clamp(0, max);
    ctrl.text = next.toString().padLeft(2, '0');
    _emit();
  }

  void _stepSeconds(int delta) {
    final currentSeconds = int.tryParse(_secondsCtrl.text) ?? 0;
    final currentMinutes = int.tryParse(_minutesCtrl.text) ?? 0;

    var newSeconds = currentSeconds + delta;
    var newMinutes = currentMinutes;

    if (newSeconds > 59) {
      newSeconds = 0;
      newMinutes = (newMinutes + 1).clamp(0, 99);
    } else if (newSeconds < 0) {
      newSeconds = 59;
      newMinutes = (newMinutes - 1).clamp(0, 99);
    }

    _minutesCtrl.text = newMinutes.toString().padLeft(2, '0');
    _secondsCtrl.text = newSeconds.toString().padLeft(2, '0');
    _emit();
  }

  Widget _digitBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    required double height,
    required double fontSize,
    VoidCallback? onFilled,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 2,
        autofillHints: const [],
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (_isExternalSync) return;
          _emit();
          if (value.length == 2) onFilled?.call();
        },
      ),
    );
  }

  Widget _chevron({required Widget icon, required VoidCallback onPressed}) {
    return IconButton(
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: icon,
    );
  }

  Widget _steppedField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required double height,
    required double fontSize,
    required void Function(int delta) onStep,
    VoidCallback? onFilled,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _chevron(
            icon: Assets.images.icChevronUp.svg(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => onStep(1),
          ),
          _digitBox(
            controller: controller,
            focusNode: focusNode,
            height: height,
            fontSize: fontSize,
            onFilled: onFilled,
          ),
          _chevron(
            icon: Assets.images.icChevronDown.svg(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => onStep(-1),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _minutesCtrl.dispose();
    _secondsCtrl.dispose();
    _minutesFocus.dispose();
    _secondsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final colonSize = (size.width * 0.3).clamp(70.0, 120.0).toDouble();
    final digitFontSize = (size.width * 0.14).clamp(40.0, 56.0).toDouble();
    final boxHeight = (size.height * 0.15).clamp(90.0, 130.0).toDouble();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _steppedField(
          controller: _minutesCtrl,
          focusNode: _minutesFocus,
          height: boxHeight,
          fontSize: digitFontSize,
          onStep: (delta) => _step(_minutesCtrl, delta, max: 99),
          onFilled: () => _secondsFocus.requestFocus(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.00),
          child: Text(
            ':',
            style: TextStyle(
              color: ThemeColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: colonSize,
            ),
          ),
        ),
        _steppedField(
          controller: _secondsCtrl,
          focusNode: _secondsFocus,
          height: boxHeight,
          fontSize: digitFontSize,
          onStep: _stepSeconds,
        ),
      ],
    );
  }
}
