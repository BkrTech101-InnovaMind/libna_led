import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:libna_system/screens/home_screen.dart';
import 'package:libna_system/store/app_store.dart';
import 'package:libna_system/theme/theme_data.dart';

AppStore appStore = AppStore();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const LibnaSystem());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> ar = {title: 'Localization'};
}

class LibnaSystem extends StatefulWidget {
  const LibnaSystem({super.key});

  @override
  State<LibnaSystem> createState() => _LibnaSystemState();
}

class _LibnaSystemState extends State<LibnaSystem> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale('ar', {"countryCode": "YE"}),
      ],
      initLanguageCode: 'ar',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeProvider.darkTheme,
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
