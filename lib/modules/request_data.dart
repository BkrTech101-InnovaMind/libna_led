import 'package:flutter/material.dart';

class RequestData {
  final String id;
  final String state;
  final Color? color;
  RequestData(this.id, {required this.state, this.color});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'color': {
        'r': color!.red,
        'g': color!.green,
        'b': color!.blue,
      },
    };
  }
}
