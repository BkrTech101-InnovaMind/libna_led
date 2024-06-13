import 'package:flutter/material.dart';

class DataSendButton extends StatelessWidget {
  final Map<String, dynamic> selectedButtonData;
  final VoidCallback onPressed;
  const DataSendButton(
      {super.key, required this.selectedButtonData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Text("Send"),
    );
  }
}
