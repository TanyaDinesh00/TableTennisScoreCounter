import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttsc/screens/settings_screen.dart';
import 'package:ttsc/screens/welcome_screen.dart';
import 'package:ttsc/screens/score_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TT ScoreCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ScoreScreen.id: (context) => ScoreScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}
