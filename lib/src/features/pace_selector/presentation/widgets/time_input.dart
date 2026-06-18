import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swim_success_test_task/core/extension/extensions.dart';
import 'package:swim_success_test_task/core/resource/theme_colors.dart';

/// Two large editable fields for minutes and seconds
class TimeInput extends StatefulWidget {
  final Duration? initialDuration;
  final ValueChanged<Duration> onChanged;

  const TimeInput({super.key, this.initialDuration, required this.onChanged});

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  late final _minutesCtrl = TextEditingController(
    text: (widget.initialDuration?.inMinutes.orZero).toString().padLeft(2, '0'),
  );
  late final _secondsCtrl = TextEditingController(
    text: ((widget.initialDuration?.inSeconds ?? 0) % 60).toString().padLeft(
      2,
      '0',
    ),
  );

  final _minutesFocus = FocusNode();
  final _secondsFocus = FocusNode();

  static const _style = TextStyle(fontSize: 56, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    // Select all text when a field gains focus, so typing replaces
    // the existing value instead of requiring manual deletion first.
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

    // Clamp seconds to 0–59 only once the user leaves the field,
    // so it doesn't fight the user mid-keystroke.
    _secondsFocus.addListener(() {
      if (!_secondsFocus.hasFocus) {
        final value = int.tryParse(_secondsCtrl.text) ?? 0;
        final clamped = value.clamp(0, 59);
        _secondsCtrl.text = clamped.toString().padLeft(2, '0');
        _emit();
      }
    });
  }

  void _emit() {
    final minutes = int.tryParse(_minutesCtrl.text) ?? 0;
    final seconds = int.tryParse(_secondsCtrl.text) ?? 0;
    widget.onChanged(Duration(minutes: minutes, seconds: seconds));
  }

  Widget _digitBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    VoidCallback? onFilled,
  }) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            height: 120,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              style: _style,
              keyboardType: TextInputType.number,
              maxLength: 2,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                _emit();
                if (value.length == 2) onFilled?.call();
              },
            ),
          ),
        ),
      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _digitBox(
          controller: _minutesCtrl,
          focusNode: _minutesFocus,
          onFilled: () => _secondsFocus.requestFocus(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.00),
          child: Text(
            ':',
            style: TextStyle(
              color: ThemeColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 120,
            ),
          ),
        ),
        _digitBox(controller: _secondsCtrl, focusNode: _secondsFocus),
      ],
    );
  }
}
