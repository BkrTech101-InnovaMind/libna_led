import 'dart:math';

import 'package:flutter/material.dart';
import 'package:libna/common/water_colors.dart';

class ColorPicker extends StatefulWidget {
  final double? width;

  final Function(Color spectrumColor, SelectableColor selectedColor)?
      onColorSelected;
  final Widget? child;

  const ColorPicker({super.key, this.onColorSelected, this.width, this.child});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  void _selectColors(Offset position) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double width = box.size.width;
    final double touchX = position.dx.clamp(0.0, width);
    final double positionRatio = touchX / width;

    final int colorCount = selectableColors.length;
    final double segmentWidth = width / (colorCount - 1);

    final int leftIndex =
        (positionRatio * (colorCount - 1)).floor().clamp(0, colorCount - 1);
    final int rightIndex =
        (positionRatio * (colorCount - 1)).ceil().clamp(0, colorCount - 1);

    final SelectableColor leftColor = selectableColors[leftIndex];
    final SelectableColor rightColor = selectableColors[rightIndex];

    final double localPosition =
        (touchX - leftIndex * segmentWidth) / segmentWidth;
    final spectrumColor =
        Color.lerp(leftColor.color, rightColor.color, localPosition)!;

    final SelectableColor selectedColor =
        localPosition <= 0.5 ? leftColor : rightColor;

    widget.onColorSelected?.call(spectrumColor, selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        _selectColors(details.localPosition);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _selectColors(details.localPosition);
      },
      child: CustomPaint(
        size: Size(widget.width ?? MediaQuery.of(context).size.width / 2, 100),
        painter: SemicirclePainter(
          colors: selectableColors
              .map((SelectableColor color) => color.color)
              .toList(),
        ),
        child: widget.child,
      ),
    );
  }
}

class SemicirclePainter extends CustomPainter {
  final List<Color> colors;
  SemicirclePainter({required this.colors});
  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.shortestSide / 1.4);
    final gradient = Paint()
      ..shader = LinearGradient(colors: colors).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, 0, -pi, false, gradient);
  }

  @override
  bool shouldRepaint(SemicirclePainter oldDelegate) => false;
}
