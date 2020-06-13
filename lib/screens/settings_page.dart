import 'package:flutter/material.dart';
import '../components/ReusableCard.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          ReusableCard(
            text: 'Change Player\'s names',
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF1D1E33),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Player 1'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Player 2'),
                  ),
                ],
              ),
            ),
          ),
          ReusableCard(
            text: 'Enter Number of Sets',
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF1D1E33),
            ),
            child: Center(
              child: Text(
                'Enter Number of Sets',
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('SAVE'),
      ),
    );
  }
}
