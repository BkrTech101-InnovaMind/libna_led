import 'package:flutter/material.dart';

class DataSendButton extends StatelessWidget {
  final Map<String, dynamic> selectedButtonData;
  final VoidCallback onPressed;
  final Color? color;

  const DataSendButton(
      {super.key,
      required this.selectedButtonData,
      required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = color?.withOpacity(0.2) ?? Colors.transparent;
    Color textColor = _getContrastingTextColor(backgroundColor);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        overlayColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(
        "Send",
        style: TextStyle(
          fontSize: 20,
          color: textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Color _getContrastingTextColor(Color backgroundColor) {
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
