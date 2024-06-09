import 'package:flutter/material.dart';

class ButtonData {
  final int id;
  final String assetName;
  final VoidCallback onPressed;

  ButtonData(this.id, this.assetName, this.onPressed);
}
