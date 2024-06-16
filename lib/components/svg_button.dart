import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libna_system/common/app_colors.dart';
import 'package:libna_system/modules/button_data.dart';

class SvgButton extends StatefulWidget {
  final ButtonData buttonData;
  final double? width;
  final bool isSelected;
  const SvgButton({
    super.key,
    required this.buttonData,
    this.width,
    required this.isSelected,
  });

  @override
  State<SvgButton> createState() => _SvgButtonState();
}

class _SvgButtonState extends State<SvgButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5),
        visualDensity: VisualDensity.compact,
      ),
      onPressed: () {
        widget.buttonData.onPressed!(widget.buttonData.id);
      },
      child: SvgPicture.asset(
        widget.buttonData.asset,
        width: widget.width ?? MediaQuery.of(context).size.width / 4,
        colorFilter: ColorFilter.mode(
          widget.isSelected ? widget.buttonData.color! : AppColors.offColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
