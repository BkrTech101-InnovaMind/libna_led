import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libna/common/app_colors.dart';
import 'package:libna/modules/button_data.dart';

class CustomButtonWithImage extends StatefulWidget {
  final ButtonData buttonData;
  final double? width;
  final bool isSelected;
  final bool isOn;
  final Function(int) onButtonSelected;
  final Color? selectedColor;

  const CustomButtonWithImage({
    super.key,
    this.width,
    required this.buttonData,
    required this.isSelected,
    required this.onButtonSelected,
    required this.isOn,
    this.selectedColor,
  });

  @override
  State<CustomButtonWithImage> createState() => _CustomButtonWithImageState();
}

class _CustomButtonWithImageState extends State<CustomButtonWithImage> {
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      label: const Text(''),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        overlayColor: Colors.transparent,
      ),
      onPressed: () {
        widget.onButtonSelected(widget.buttonData.id);
        widget.buttonData.onPressed();
      },
      icon: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.isSelected) ...[
            Positioned(
              top: -2,
              left: -2,
              child: SvgPicture.asset(
                widget.buttonData.assetName,
                width: widget.width ?? MediaQuery.of(context).size.width / 4,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: SvgPicture.asset(
                widget.buttonData.assetName,
                width: widget.width ?? MediaQuery.of(context).size.width / 4,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
          SvgPicture.asset(
            widget.buttonData.assetName,
            width: widget.width ?? MediaQuery.of(context).size.width / 4,
            colorFilter: ColorFilter.mode(
              widget.isOn
                  ? widget.selectedColor ?? AppColors.onColor
                  : widget.isSelected
                      ? widget.isOn
                          ? AppColors.onColor
                          : AppColors.offColor
                      : AppColors.offColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
