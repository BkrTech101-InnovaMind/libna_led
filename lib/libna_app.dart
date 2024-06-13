import 'package:flutter/material.dart';
import 'package:libna/common/app_colors.dart';
import 'package:libna/common/images_paths.dart';
import 'package:libna/common/water_colors.dart';
import 'package:libna/components/color_picker.dart';
import 'package:libna/components/data_send_button.dart';
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
  String? activeEffectButtonId;
  Map<String, bool> buttonStates = {};
  Map<String, Color> buttonColors = {};
  Map<String, dynamic> selectedButtonData = {};

  void _updateButtonData() {
    bool allButtonsOn = true;
    bool isEffectButtonSelected = _isEffectButton(selectedButtonId);

    // Check if all non-effect buttons are on
    buttonStates.forEach((key, value) {
      if (!_isEffectButton(key) && !value) {
        allButtonsOn = false;
      }
    });

    if (selectedButtonId != "-1") {
      String idToSend;

      if (isEffectButtonSelected) {
        // Effect button is selected, send "all"
        idToSend = "all";
      } else {
        // Non-effect button is selected
        if (allButtonsOn) {
          // All non-effect buttons are on, send "all"
          idToSend = "all";
        } else {
          // Send the selected button's IP
          idToSend = '192.168.0.$selectedButtonId';
        }
      }

      bool isOn = buttonStates[selectedButtonId] ?? false;
      Color color = buttonColors[selectedButtonId] ?? AppColors.onColor;

      String? effectLetter =
          isEffectButtonSelected && buttonStates[activeEffectButtonId]!
              ? activeEffectButtonId
              : "None";

      selectedButtonData = {
        'id': idToSend,
        'state': isOn ? "On" : "Off",
        'color': 'RGB(${color.red}, ${color.green}, ${color.blue})',
        'effect': effectLetter,
      };
    }
  }

  void _onButtonSelected(dynamic id) {
    setState(() {
      selectedButtonId = id;
    });
    _updateButtonData();
  }

  void _onPowerButtonPressed() {
    if (selectedButtonId != "-1") {
      setState(() {
        bool isCurrentlyOn = buttonStates[selectedButtonId] ?? false;

        bool isEffectButton = _isEffectButton(selectedButtonId);

        if (!isCurrentlyOn && isEffectButton) {
          activeEffectButtonId = selectedButtonId;

          buttonStates.forEach((key, value) {
            if (key != selectedButtonId && _isEffectButton(key)) {
              buttonStates[key] = false;
            }
          });
        }

        buttonStates[selectedButtonId] = !isCurrentlyOn;

        if (buttonStates[selectedButtonId]! && isEffectButton) {
          selectedButtonId = selectedButtonId;
        }
      });
      _updateButtonData();
    }
  }

  void _onColorSelected(Color spectrumColor, SelectableColor selectedColor) {
    if (selectedButtonId != "-1" && !_isEffectButton(selectedButtonId)) {
      setState(() {
        buttonColors[selectedButtonId] = spectrumColor;
      });
      _updateButtonData();
    }
  }

  bool _isEffectButton(String id) {
    final effectButtonIds = ["A", "B", "C", "D", "E"];
    return effectButtonIds.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeProvider.darkTheme,
      title: 'Libna App',
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                      buttonData: ButtonData(
                          "6", ImagesPathes.stairsRightButton, () {}),
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
        floatingActionButton: DataSendButton(
            selectedButtonData: selectedButtonData,
            onPressed: () => print(selectedButtonData)),
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
      const SizedBox(height: 20),
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
      const SizedBox(height: 20),
      CustomButtonWithImage(
        buttonData: ButtonData("5", ImagesPathes.floorButton, () {}),
        isSelected: selectedButtonId == "5",
        isOn: buttonStates["5"] ?? false,
        onButtonSelected: _onButtonSelected,
        selectedColor: buttonColors["5"],
        width: MediaQuery.of(context).size.width / 2.4,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            child: CustomButtonWithImage(
              buttonData: ButtonData(button.id, button.assetName, () {}),
              isSelected: selectedButtonId == button.id,
              isOn: buttonStates[button.id] ?? false,
              onButtonSelected: _onButtonSelected,
              width: MediaQuery.of(context).size.width / 8,
              isEffect: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
