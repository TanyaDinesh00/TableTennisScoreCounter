import 'package:flutter/material.dart';
import '../services/logic.dart';
import 'settings_screen.dart';
import '../components/ReusableCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ScoreScreen extends StatefulWidget {
  static const String id = 'main_screen';

  ScoreScreen({this.currentGameID});
  final String currentGameID;
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  Score s = new Score();
  String docID, gameName, player1, player2;

  void getData() async {
    await for (var snapshots in _firestore.collection('games').snapshots()) {
      for (var game in snapshots.documents) {
        if (game.documentID == widget.currentGameID) {
          docID = game.documentID;

          setState(() {
            gameName = game.data['name'];
            player1 = game.data['player1'];
            player2 = game.data['player2'];

            s.gameNum = game.data['gameNum'];
            s.score1 = game.data['score1'];
            s.score2 = game.data['score2'];
            s.won1 = game.data['won1'];
            s.won2 = game.data['won2'];

            s.serve = game.data['serve'];
            s.serve1 = game.data['serve1'];
            s.serve2 = game.data['serve2'];

            s.victory = game.data['victory'];
            s.rounds = game.data['rounds'];
            s.end = game.data['end'];
            s.count = game.data['count'];
            s.s_end = game.data['s_end'];
            s.service = game.data['service'];
          });
        }
      }
    }
  }

  void updateData() {
    print('updating ');
    _firestore.collection('games').document(docID).updateData({
      'gameNum': s.gameNum,
      'score1': s.score1,
      'score2': s.score2,
      'won1': s.won1,
      'won2': s.won2,

      'serve': s.serve,
      'serve1': s.serve1,
      'serve2': s.serve2,
      'service': s.service,

      'victory': s.victory,
      'rounds': s.rounds,
      'end': s.end,
      'count': s.count,
      's_end': s.s_end,
      //'service': p4.text,
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void buttonAction(int n) {
    setState(() {
      if (n == 1) {
        s.s1();
      }
      if (n == 2) {
        s.s2();
      }
      if (n == 3) {
        s.reset();
      }
      if (n == 4) {
        s.hardReset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                //Scaffold.of(context).openDrawer();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsScreen(
                              gameID: docID,
                            )));
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text('Live Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.blue[600],
                    radius: 40,
                    backgroundImage: AssetImage('images/b.jpg'),
                  ),
                  Text(
                    'Game ' + s.get_game(),
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red[600],
                    backgroundImage: AssetImage('images/a.jpg'),
                  ),
                ],
              ),
            ), // Faces and game number
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF1D1E33),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$player1 ',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                    Text(
                      'vs',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                    Text(
                      ' $player2',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ), // Players' names
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (!s.s_end) {
                              buttonAction(1);
                              updateData();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              s.get_won1(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: new FlatButton(
                          onPressed: () {
                            if (!s.s_end) {
                              buttonAction(1);
                              updateData();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Text(
                            '${s.score1}\n${s.serve1}',
                            style: TextStyle(color: Colors.black, fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: new FlatButton(
                          onPressed: () {
                            if (!s.s_end) {
                              buttonAction(2);
                              updateData();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Text(
                            s.get_score2(),
                            style: TextStyle(color: Colors.black, fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (!s.s_end) {
                              buttonAction(2);
                              updateData();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              s.get_won2(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ), // Scores
            Expanded(
              child: ReusableCard(text: s.get_rounds()),
            ), // ScoreTab
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buttonAction(3);
          updateData();
        },
        child: GestureDetector(
          child: Text('Reset'),
          onLongPress: () {
            buttonAction(4);
            updateData();
          },
        ),
      ),
    );
  }
}
