import 'package:flutter/material.dart';
import 'package:libna/common/images_paths.dart';
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
  int selectedButtonId = -1;
  Map<int, bool> buttonStates = {};

  void _onButtonSelected(int id) {
    setState(() {
      selectedButtonId = id;
    });
    print(
        'Button ID: $selectedButtonId ${buttonStates[selectedButtonId] == true ? "On" : "Off"}');
  }

  void _onPowerButtonPressed() {
    _onButtonSelected(selectedButtonId);
    if (selectedButtonId != -1) {
      setState(() {
        buttonStates[selectedButtonId] =
            !(buttonStates[selectedButtonId] ?? false);
      });
      print(
          'Button ID: $selectedButtonId, State: ${buttonStates[selectedButtonId] == true ? "On" : "Off"}');
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
                        ButtonData(6, ImagesPathes.stairsLeftButton, () {}),
                    isSelected: selectedButtonId == 6,
                    isOn: buttonStates[6] ?? false,
                    onButtonSelected: _onButtonSelected,
                  ),
                  _buildPickerSection(context),
                  CustomButtonWithImage(
                    buttonData:
                        ButtonData(6, ImagesPathes.stairsRightButton, () {}),
                    isSelected: selectedButtonId == 6,
                    isOn: buttonStates[6] ?? false,
                    onButtonSelected: _onButtonSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData(2, ImagesPathes.woolLeftButton, () {}),
      ButtonData(3, ImagesPathes.woolMiddleButton, () {}),
      ButtonData(4, ImagesPathes.woolRightButton, () {}),
    ];
    return Column(children: [
      CustomButtonWithImage(
        width: MediaQuery.of(context).size.width / 1.5,
        buttonData: ButtonData(1, ImagesPathes.woolTopButton, () {}),
        isSelected: selectedButtonId == 1,
        isOn: buttonStates[1] ?? false,
        onButtonSelected: _onButtonSelected,
      ),
      Row(
        children: buttons.map((button) {
          return Expanded(
            child: CustomButtonWithImage(
              buttonData: ButtonData(button.id, button.assetName, () {}),
              isSelected: selectedButtonId == button.id,
              isOn: buttonStates[button.id] ?? false,
              onButtonSelected: _onButtonSelected,
            ),
          );
        }).toList(),
      ),
      CustomButtonWithImage(
        buttonData: ButtonData(5, ImagesPathes.floorButton, () {}),
        isSelected: selectedButtonId == 5,
        isOn: buttonStates[5] ?? false,
        onButtonSelected: _onButtonSelected,
      ),
    ]);
  }

  Widget _buildPickerSection(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          onColorSelected: (spectrumColor, selectedColor) {},
        ),
        CustomButtonWithImage(
          buttonData:
              ButtonData(0, ImagesPathes.powerButton, _onPowerButtonPressed),
          isSelected: false,
          isOn: false,
          onButtonSelected: (id) {},
        )
      ],
    );
  }
}
