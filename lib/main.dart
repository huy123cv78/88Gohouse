import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/QT_login/login_screen.dart';
import 'package:flutter_application_1/screens/QT_login/verification_successful.dart';
import 'package:flutter_application_1/screens/maintenance_screen.dart';
import 'package:flutter_application_1/screens/QT_login/register.dart';
import 'package:flutter_application_1/screens/QT_login/emergency_contact.dart';
import 'package:flutter_application_1/screens/QT_login/verify_phone.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VI'),
        Locale('zh', 'ZH'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/language',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: '88GO HOUSE',
      home: const LoginScreen(),
    );
  }
}
