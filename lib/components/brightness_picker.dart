import 'package:flutter/material.dart';
import 'package:libna_system/common/app_colors.dart';

class BrightnessPicker extends StatefulWidget {
  final Function(int brightnessValue)? onBrightnessMoved;
  final Color? baseColor;
  const BrightnessPicker({super.key, this.onBrightnessMoved, this.baseColor});

  @override
  State<BrightnessPicker> createState() => _BrightnessPickerState();
}

class _BrightnessPickerState extends State<BrightnessPicker> {
  double brightnessValue = 127.0;
  @override
  Widget build(BuildContext context) {
    return Slider(
      thumbColor: AppColors.activeEffectColor,
      activeColor: AppColors.selectedColor,
      allowedInteraction: SliderInteraction.tapAndSlide,
      overlayColor:
          WidgetStateProperty.all(AppColors.selectedColor.withOpacity(0.4)),
      inactiveColor: widget.baseColor == AppColors.selectedColor
          ? AppColors.activeEffectColor
          : widget.baseColor ?? AppColors.offColor,
      divisions: 255,
      value: brightnessValue,
      min: 0,
      max: 255,
      onChanged: (value) {
        setState(() {
          brightnessValue = value;
          widget.onBrightnessMoved?.call(value.toInt());
        });
      },
    );
  }
}
