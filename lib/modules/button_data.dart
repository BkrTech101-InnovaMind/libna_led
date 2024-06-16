import 'package:flutter/material.dart';

class ButtonData {
  late String id;
  late String state;
  late Color? color;
  final String asset;
  final Function(dynamic)? onPressed;

  ButtonData(this.id,
      {required this.asset, required this.state, this.color, this.onPressed});
}
