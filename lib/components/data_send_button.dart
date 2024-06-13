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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: color?.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        overlayColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text("Send",
          style: TextStyle(
              fontSize: 20,
              color: color ?? Colors.white,
              fontWeight: FontWeight.w900)),
    );
  }
}
