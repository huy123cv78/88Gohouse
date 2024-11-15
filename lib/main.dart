import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/QT_login/login_screen.dart';
import 'package:flutter_application_1/screens/QT_login/verification_successful.dart';
import 'package:flutter_application_1/screens/maintenance_screen.dart';
import 'package:flutter_application_1/screens/QT_login/register.dart';
import 'package:flutter_application_1/screens/QT_login/emergency_contact.dart';
import 'package:flutter_application_1/screens/QT_login/verify_phone.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('vi', ''), // TiengViet
        Locale('zh-cn', '') //china
      ],
      home: LoginScreen(),
    );
  }
}
