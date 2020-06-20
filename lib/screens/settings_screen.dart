import 'package:flutter/material.dart';
import 'package:ttsc/screens/score_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttsc/components/wide_button.dart';

final _firestore = Firestore.instance;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({this.gameID});
  var gameID;
  static const String id = 'settings_page';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String gameName, player1, player2, sets, service, docID;
  var p0 = TextEditingController();
  var p1 = TextEditingController();
  var p2 = TextEditingController();
  var p3 = TextEditingController();
  var p4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await for (var snapshots in _firestore.collection('games').snapshots()) {
      for (var game in snapshots.documents) {
        if (game.documentID == widget.gameID) {
          docID = game.documentID;
          gameName = game.data['name'];
          player1 = game.data['player1'];
          player2 = game.data['player2'];
          sets = game.data['sets'];
          service = game.data['service'];
          p0.text = '$gameName';
          p1.text = '$player1';
          p2.text = '$player2';
          p3.text = '$sets';
          p4.text = '$service';
        }
      }
    }
  }

  addData() async {
    if (p0.text == '') {
      _showMyDialog();
      return;
    }
    var docRef = await _firestore.collection('games').add({
      'name': p0.text,
      'player1': p1.text,
      'player2': p2.text,
      'sets': p3.text,
      'service': p4.text,
      'gameNum': 0,
      'won1': 0,
      'won2': 0,
      'victory': '',
      'rounds': '',
      's_end': false,
      'score1': 0,
      'score2': 0,
      'serve1': '*',
      'serve2': '',
      'end': false,
      'count': 0,
      'serve': 1,
    }).catchError((e) {
      print(e);
    });
    print(docRef.documentID);
    setState(() {
      widget.gameID = docRef.documentID;
    });
  }

  updateData() {
    print('updating ');
    _firestore.collection('games').document(docID).updateData({
      'name': p0.text,
      'player1': p1.text,
      'player2': p2.text,
      'sets': p3.text,
      'service': p4.text,
    }).catchError((e) {
      print(e);
    });
  }

  deleteData() async {
    await _firestore
        .collection('games')
        .document(docID)
        .delete()
        .catchError((e) {
      print(e);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Set-Up'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF1D1E33),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Game Name",
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                    ),
                    TextField(
                      controller: p0,
                      decoration: InputDecoration(labelText: 'Game Name'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF1D1E33),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Player's Names",
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                    ),
                    TextField(
                      controller: p1,
                      decoration: InputDecoration(labelText: 'Player 1'),
                    ),
                    TextField(
                      controller: p2,
                      decoration: InputDecoration(labelText: 'Player 2'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF1D1E33),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Game Settings",
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                    ),
                    TextField(
                      controller: p3,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(labelText: 'Sets'),
                    ),
                    TextField(
                      controller: p4,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(labelText: 'Initial Service'),
                    ),
                  ],
                ),
              ),
            ),
            WideButton(
              text: 'Start',
              color: Colors.green,
              onTap: () {
                if (widget.gameID != 'new_game') {
                  updateData();
                } else {
                  addData();
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ScoreScreen(
                    currentGameID: widget.gameID,
                  );
                }));
              },
            ),
            WideButton(
              text: 'Save',
              color: Colors.blue,
              onTap: () {
                if (widget.gameID != 'new_game') {
                  updateData();
                } else {
                  addData();
                }
              },
            ),
            WideButton(
              text: 'Delete',
              color: Colors.red,
              onTap: () {
                deleteData();
              },
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          if (widget.gameID != 'new_game') {
//            updateData();
//          } else {
//            addData();
//          }
//
//          //Navigator.pushNamed(context, ScoreScreen.id);
//        },
//        child: Text('SAVE'),
//      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Game Title Empty'),
                Text('Game Title cant br left empty!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
