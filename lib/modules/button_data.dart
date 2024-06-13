import 'package:flutter/material.dart';

class ButtonData {
  final dynamic id;
  final String assetName;
  final VoidCallback onPressed;

  ButtonData(this.id, this.assetName, this.onPressed);
}
