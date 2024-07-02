import 'package:flutter/material.dart';
import 'package:libna_system/common/app_colors.dart';
import 'package:libna_system/common/images_paths.dart';
import 'package:libna_system/components/brightness_picker.dart';
import 'package:libna_system/components/color_picker.dart';
import 'package:libna_system/components/footer_text.dart';
import 'package:libna_system/components/spinner.dart';
import 'package:libna_system/components/svg_button.dart';
import 'package:libna_system/modules/button_data.dart';
import 'package:libna_system/utils/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String effect = "0";
  int brightness = 0;
  ButtonData buttonData =
      ButtonData("", asset: "", state: "0", color: AppColors.selectedColor);

  void _onEffectSelected(dynamic fx) {
    setState(() {
      effect = effect == fx ? "0" : fx;
    });
  }

  void _onLampButtonSelected(String id) {
    setState(() {
      buttonData.id = id;
    });
  }

  void _onPowerButtonClicked(_) {
    if (buttonData.id != '') {
      setState(() {
        buttonData.state = buttonData.state == "0" ? "1" : "0";
      });
    }
  }

  void _onColorSelected(Color spectrumColor) {
    setState(() {
      buttonData.color = spectrumColor;
    });
  }

  void _onBrightnessMoved(int brightnessValue) {
    setState(() {
      brightness = brightnessValue;
    });
  }

  void _onSend(_) {
    if (buttonData.id == "6") {
      sendData(
        context,
        id: "6",
        state: buttonData.state,
        brightness: brightness.toString(),
        color: buttonData.color!,
        fx: effect,
      );
      sendData(
        context,
        id: "7",
        state: buttonData.state,
        brightness: brightness.toString(),
        color: buttonData.color!,
        fx: effect,
      );
    } else {
      sendData(
        context,
        id: buttonData.id,
        state: buttonData.state,
        brightness: brightness.toString(),
        color: buttonData.color!,
        fx: effect,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgButton(
                    buttonData: ButtonData(
                      "1",
                      asset: ImagesPathes.woolTopButton,
                      state: "1",
                      onPressed: _onLampButtonSelected,
                      color: buttonData.color,
                    ),
                    isSelected: buttonData.id == "1",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 15),
                  _buildWallsSection(context),
                  const SizedBox(height: 15),
                  SvgButton(
                    buttonData: ButtonData(
                      "5",
                      asset: ImagesPathes.floorButton,
                      state: buttonData.state,
                      onPressed: _onLampButtonSelected,
                      color: buttonData.color,
                    ),
                    isSelected: buttonData.id == "5",
                  ),
                  _buildMiddleSection(context),
                  const SizedBox(height: 15),
                  ColorPicker(
                    onColorSelected: _onColorSelected,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: BrightnessPicker(
                      onBrightnessMoved: _onBrightnessMoved,
                      baseColor: buttonData.color,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildEffectsSection(context),
                  const SizedBox(height: 50),
                  const FooterText(),
                ],
              ),
            ),
            Positioned.fill(
              child: SpinKitChasingDots(color: buttonData.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWallsSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData("2",
          asset: ImagesPathes.woolRightButton,
          state: buttonData.state,
          color: buttonData.color,
          onPressed: _onLampButtonSelected),
      ButtonData("3",
          asset: ImagesPathes.woolMiddleButton,
          state: buttonData.state,
          color: buttonData.color,
          onPressed: _onLampButtonSelected),
      ButtonData("4",
          asset: ImagesPathes.woolLeftButton,
          state: buttonData.state,
          color: buttonData.color,
          onPressed: _onLampButtonSelected),
    ];
    return Row(
      children: buttons
          .map((button) => Expanded(
                child: SvgButton(
                  isSelected: buttonData.id == button.id,
                  buttonData: button,
                  width: MediaQuery.of(context).size.width / 4.5,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildMiddleSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData(
        "6",
        asset: ImagesPathes.stairsRightButton,
        state: buttonData.state,
        onPressed: _onLampButtonSelected,
        color: buttonData.color,
      ),
      ButtonData(
        "",
        asset: ImagesPathes.sendButton,
        state: "",
        onPressed: _onSend,
      ),
      ButtonData(
        "",
        asset: ImagesPathes.powerButton,
        state: "",
        onPressed: _onPowerButtonClicked,
        color: AppColors.selectedColor,
      ),
      ButtonData(
        "6",
        asset: ImagesPathes.stairsLeftButton,
        state: buttonData.state,
        onPressed: _onLampButtonSelected,
        color: buttonData.color,
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: buttons
          .map((button) => Expanded(
                child: Container(
                  padding: button.asset == ImagesPathes.sendButton
                      ? EdgeInsets.all(MediaQuery.of(context).size.width / 30)
                      : null,
                  decoration: BoxDecoration(
                    color: button.asset == ImagesPathes.sendButton
                        ? AppColors.selectedColor
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: SvgButton(
                    isSelected: button.asset == ImagesPathes.powerButton
                        ? buttonData.state == "1"
                        : button.asset == ImagesPathes.sendButton
                            ? false
                            : buttonData.id == button.id,
                    buttonData: button,
                    width: button.id != "6" && button.id != "7"
                        ? button.asset == ImagesPathes.sendButton
                            ? MediaQuery.of(context).size.width / 15
                            : MediaQuery.of(context).size.width / 7.5
                        : null,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildEffectsSection(BuildContext context) {
    final List<ButtonData> buttons = [
      ButtonData(
        "1",
        asset: ImagesPathes.buttonA,
        state: "",
        color: AppColors.activeEffectColor,
        onPressed: _onEffectSelected,
      ),
      ButtonData(
        "2",
        asset: ImagesPathes.buttonB,
        state: "",
        color: AppColors.activeEffectColor,
        onPressed: _onEffectSelected,
      ),
      ButtonData(
        "3",
        asset: ImagesPathes.buttonC,
        state: "",
        color: AppColors.activeEffectColor,
        onPressed: _onEffectSelected,
      ),
      ButtonData(
        "4",
        asset: ImagesPathes.buttonD,
        state: "",
        color: AppColors.activeEffectColor,
        onPressed: _onEffectSelected,
      ),
      ButtonData(
        "5",
        asset: ImagesPathes.buttonE,
        state: "",
        color: AppColors.activeEffectColor,
        onPressed: _onEffectSelected,
      ),
    ];

    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttons
          .map(
            (button) => Expanded(
              child: SvgButton(
                isSelected: effect == button.id,
                buttonData: button,
                width: MediaQuery.of(context).size.width / 9,
              ),
            ),
          )
          .toList(),
    );
  }
}
