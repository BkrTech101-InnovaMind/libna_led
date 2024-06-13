import 'package:flutter/material.dart';
import 'package:libna/common/app_colors.dart';
import 'package:libna/common/images_paths.dart';
import 'package:libna/common/water_colors.dart';
import 'package:libna/components/color_picker.dart';
import 'package:libna/components/image_buton.dart';
import 'package:libna/modules/button_data.dart';
import 'package:libna/theme/theme_data.dart';

class LibnaApp extends StatefulWidget {
  const LibnaApp({super.key});

  @override
  State<LibnaApp> createState() => _LibnaAppState();
}

class _LibnaAppState extends State<LibnaApp> {
  String selectedButtonId = "-1";
  Map<String, bool> buttonStates = {};
  Map<String, Color> buttonColors = {};

  void _onButtonSelected(dynamic id) {
    setState(() {
      selectedButtonId = id;
    });
    Color color = buttonColors[id] ?? AppColors.onColor;
    print(
        'Button ID: $selectedButtonId State: ${buttonStates[selectedButtonId] == true ? "On" : "Off"} Color: RGB(${color.red}, ${color.green}, ${color.blue})');
  }

  void _onPowerButtonPressed() {
    _onButtonSelected(selectedButtonId);
    if (selectedButtonId != "-1") {
      setState(() {
        buttonStates[selectedButtonId] =
            !(buttonStates[selectedButtonId] ?? false);
      });
      bool isOn = buttonStates[selectedButtonId] == true;
      Color color = buttonColors[selectedButtonId] ?? AppColors.onColor;
      print(
          'Button ID: $selectedButtonId, State: ${isOn ? "On" : "Off"}, Color: RGB(${color.red}, ${color.green}, ${color.blue})');
    }
  }

  void _onColorSelected(Color spectrumColor, SelectableColor selectedColor) {
    if (selectedButtonId != "-1") {
      setState(() {
        buttonColors[selectedButtonId] = spectrumColor;
      });
      bool isOn = buttonStates[selectedButtonId] == true;
      Color color = buttonColors[selectedButtonId] ?? AppColors.onColor;
      print(
          'Button ID: $selectedButtonId, State: ${isOn ? "On" : "Off"}, Color: RGB(${color.red}, ${color.green}, ${color.blue})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeProvider.darkTheme,
      title: 'Libna App',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildFirstSection(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWithImage(
                    buttonData:
                        ButtonData("6", ImagesPathes.stairsLeftButton, () {}),
                    isSelected: selectedButtonId == "6",
                    isOn: buttonStates["6"] ?? false,
                    onButtonSelected: _onButtonSelected,
                    selectedColor: buttonColors["6"],
                  ),
                  _buildPickerSection(context),
                  CustomButtonWithImage(
                    buttonData:
                        ButtonData("6", ImagesPathes.stairsRightButton, () {}),
                    isSelected: selectedButtonId == "6",
                    isOn: buttonStates["6"] ?? false,
                    onButtonSelected: _onButtonSelected,
                    selectedColor: buttonColors["6"],
                  ),
                ],
              ),
              _buildEffectsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData("2", ImagesPathes.woolLeftButton, () {}),
      ButtonData("3", ImagesPathes.woolMiddleButton, () {}),
      ButtonData("4", ImagesPathes.woolRightButton, () {}),
    ];
    return Column(children: [
      CustomButtonWithImage(
        width: MediaQuery.of(context).size.width / 1.5,
        buttonData: ButtonData("1", ImagesPathes.woolTopButton, () {}),
        isSelected: selectedButtonId == "1",
        isOn: buttonStates["1"] ?? false,
        onButtonSelected: _onButtonSelected,
        selectedColor: buttonColors["1"],
      ),
      Row(
        children: buttons.map((button) {
          return Expanded(
            child: CustomButtonWithImage(
              buttonData: ButtonData("${button.id}", button.assetName, () {}),
              isSelected: selectedButtonId == button.id,
              isOn: buttonStates[button.id] ?? false,
              onButtonSelected: _onButtonSelected,
              selectedColor: buttonColors[button.id],
            ),
          );
        }).toList(),
      ),
      CustomButtonWithImage(
        buttonData: ButtonData("5", ImagesPathes.floorButton, () {}),
        isSelected: selectedButtonId == "5",
        isOn: buttonStates["5"] ?? false,
        onButtonSelected: _onButtonSelected,
        selectedColor: buttonColors["5"],
      ),
    ]);
  }

  Widget _buildPickerSection(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 5;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 2, vertical: width / 2),
      child: ColorPicker(
        onColorSelected: _onColorSelected,
        width: width,
        child: CustomButtonWithImage(
          buttonData:
              ButtonData("0", ImagesPathes.powerButton, _onPowerButtonPressed),
          isSelected: false,
          isOn: false,
          onButtonSelected: (id) {},
          width: width,
        ),
      ),
    );
  }

  Widget _buildEffectsSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData("A", ImagesPathes.buttonA, () {}),
      ButtonData("B", ImagesPathes.buttonB, () {}),
      ButtonData("C", ImagesPathes.buttonC, () {}),
      ButtonData("D", ImagesPathes.buttonD, () {}),
      ButtonData("E", ImagesPathes.buttonE, () {}),
    ];
    return Row(
      children: buttons.map((button) {
        return Expanded(
          child: CustomButtonWithImage(
            buttonData: ButtonData(button.id, button.assetName, () {}),
            isSelected: selectedButtonId == button.id,
            isOn: buttonStates[button.id] ?? false,
            onButtonSelected: _onButtonSelected,
            width: MediaQuery.of(context).size.width / 6,
            isEffect: true,
          ),
        );
      }).toList(),
    );
  }
}
