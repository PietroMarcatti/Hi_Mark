import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_mark/Components/rounded_button.dart';
import 'package:hi_mark/Screens/welcome_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
              title: 'Sign Out',
              colour: Colors.lightBlue,
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
      ),
    );
  }
}
