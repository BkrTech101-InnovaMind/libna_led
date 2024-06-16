import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libna_system/common/app_colors.dart';

class ColorPicker extends StatefulWidget {
  final double? width;
  final Function(Color spectrumColor)? onColorSelected;

  const ColorPicker({super.key, this.onColorSelected, this.width});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  ui.Image? image;
  Color selectedColor = Colors.transparent;
  Offset currentPosition = const Offset(150, 150);

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/picker.png');
    final Uint8List bytes = Uint8List.view(data.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
  }

  void _selectColors(Offset position) {
    if (image == null) return;

    double x =
        (position.dx / context.size!.width * image!.width).toInt().toDouble();
    double y =
        (position.dy / context.size!.height * image!.height).toInt().toDouble();

    if (x < 0 || x >= image!.width || y < 0 || y >= image!.height) return;

    int xPos = x.toInt();
    int yPos = y.toInt();

    image!.toByteData(format: ui.ImageByteFormat.rawRgba).then((byteData) {
      if (byteData == null) return;
      final int pixelIndex = (yPos * image!.width + xPos) * 4;
      final int r = byteData.getUint8(pixelIndex);
      final int g = byteData.getUint8(pixelIndex + 1);
      final int b = byteData.getUint8(pixelIndex + 2);
      final int a = byteData.getUint8(pixelIndex + 3);

      final Color color = Color.fromARGB(a, r, g, b);
      setState(() {
        selectedColor = color;
        currentPosition = position;
      });
      widget.onColorSelected?.call(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.lerp(
          Alignment.topLeft, Alignment.bottomRight, 0.5)!,
      children: [
        GestureDetector(
          onPanDown: (DragDownDetails details) {
            _selectColors(details.localPosition);
          },
          onPanUpdate: (DragUpdateDetails details) {
            _selectColors(details.localPosition);
          },
          child: RawImage(
            image: image,
            width: widget.width ?? MediaQuery.of(context).size.width / 4,
          ),
        ),
        Positioned(
          left: currentPosition.dx - 10,
          top: currentPosition.dy - 10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.activeEffectColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.offColor, width: 2),
            ),
            width: 20,
            height: 20,
          ),
        )
      ],
    );
  }
}
