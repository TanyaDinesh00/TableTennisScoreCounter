import 'package:flutter/material.dart';
import 'package:ttsc/components/ReusableCard.dart';
import 'package:ttsc/components/bottom_button.dart';
import 'package:ttsc/screens/score_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('TT ScoreCounter'),
        //backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ReusableCard(
              text: 'Choose an Existing Game',
            ),
            Expanded(
              child: Container(),
            ),
            BottomButton(
              buttonTitle: 'Start Game',
              onTap: () {
                Navigator.pushNamed(context, ScoreScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
