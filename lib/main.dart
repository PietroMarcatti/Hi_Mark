import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hi_mark/Screens/home_screen.dart';
import 'package:hi_mark/Screens/lists_screen.dart';
import 'package:hi_mark/Screens/login_screen.dart';
import 'package:hi_mark/Screens/product_screen.dart';
import 'package:hi_mark/Screens/registration_screen.dart';
import 'package:hi_mark/Screens/scanner_screen.dart';
import 'package:hi_mark/Screens/settings_screen.dart';
import 'package:hi_mark/Screens/welcome_screen.dart';

void main() => runApp(HiMark());

class HiMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProductScreen.id: (context) => ProductScreen(),
        ScannerScreen.id: (context) => ScannerScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ListsScreen.id: (context) => ListsScreen(),
      },
    );
  }
}
