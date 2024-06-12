import 'package:flutter/material.dart';
import 'package:libna/common/water_colors.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, this.onColorSelected});

  final Function(Color spectrumColor, SelectableColor selectedColor)?
      onColorSelected;

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

    print(
        'Selected color: RGB(${spectrumColor.red}, ${spectrumColor.green}, ${spectrumColor.blue})');
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
      child: ColorSpectrum(
        colors: selectableColors
            .map((SelectableColor color) => color.color)
            .toList(),
      ),
    );
  }
}

class ColorSpectrum extends StatelessWidget {
  const ColorSpectrum({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: colors,
      )),
    );
  }
}
