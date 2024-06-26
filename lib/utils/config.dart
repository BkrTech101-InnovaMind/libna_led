import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libna_system/components/messenger.dart';
import 'package:libna_system/utils/show_snack_bar.dart';

const String baseUrl = "192.168.1.";

const String urlRout = "/le/win&";

const String stateRout = "T=";

const String brightnessRout = "A=";

const String rRout = "R=";
const String gRout = "G=";
const String bRout = "B=";

const String effectsRout = "FX=";

void sendData(
  BuildContext context, {
  required String id,
  required String state,
  required String brightness,
  required Color color,
  required String fx,
}) async {
  final url = Uri.http(
    "$baseUrl$id",
    "$urlRout$stateRout$state&$brightnessRout$brightness&$rRout${color.red}&$gRout${color.green}&$bRout${color.blue}&$effectsRout$fx",
  );
  log("$url");
  try {
    final res = await http.post(url);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 202) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'تم التعيين بنجاح',
        ),
      );
    }
    log("${res.statusCode}");
  } catch (e) {
    log("$e");
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: 'خطأ: $e',
      ),
    );
  }
}
