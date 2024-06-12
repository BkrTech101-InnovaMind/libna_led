import 'package:flutter/material.dart';

class WaterColorDescription {
  final String id;
  final String name;
  final String description;
  final Color color;

  WaterColorDescription(
      {required this.id,
      required this.name,
      required this.description,
      required this.color});
}

class SelectableColor {
  final String id;
  final Color color;

  SelectableColor({required this.id, required this.color});
}

final List<WaterColorDescription> waterColors = [
  WaterColorDescription(
    id: 'red',
    name: 'Red Color',
    description: 'Red Whatercolor',
    color: Colors.red.shade500,
  ),
  WaterColorDescription(
    id: 'orange',
    name: 'Orange Color',
    description: 'Orange Whatercolor',
    color: Colors.orange.shade500,
  ),
  WaterColorDescription(
    id: 'yellow',
    name: 'Yellow Color',
    description: 'Yellow Whatercolor',
    color: Colors.yellow.shade500,
  ),
  WaterColorDescription(
    id: 'green',
    name: 'Green Color',
    description: 'Green Whatercolor',
    color: Colors.green.shade500,
  ),
  WaterColorDescription(
    id: 'blue',
    name: 'Blue Color',
    description: 'Blue Whatercolor',
    color: Colors.blue.shade500,
  ),
  WaterColorDescription(
    id: 'indigo',
    name: 'Indigo Color',
    description: 'Indigo Whatercolor',
    color: Colors.indigo.shade500,
  ),
  WaterColorDescription(
    id: 'violet',
    name: 'Violet Color',
    description: 'Violet Whatercolor',
    color: Colors.purple.shade500,
  ),
];

final List<SelectableColor> selectableColors =
    waterColors.map((WaterColorDescription description) {
  return SelectableColor(id: description.id, color: description.color);
}).toList();

findWhaterColorDescriptionById(String id) {
  return waterColors.firstWhere((element) => element.id == id);
}
