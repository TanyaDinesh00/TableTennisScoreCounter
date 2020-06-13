import 'package:flutter/material.dart';
import 'package:ttsc/components/ReusableCard.dart';
import 'package:ttsc/components/bottom_button.dart';
import 'package:ttsc/components/game_list_card.dart';
import 'package:ttsc/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttsc/screens/settings_screen.dart';

final _firestore = Firestore.instance;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedGame = 'New Game';

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
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('games').snapshots(),
              builder: (context, snapshot) {
                final games = snapshot.data.documents;
                List<GameListCard> gameCards = [];
                final gameCard = GameListCard(
                  onTap: () {
                    selectedGame = 'new_game';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingsScreen(
                        gameID: selectedGame,
                      );
                    }));
                  },
                  text: 'New Game',
                  color: Colors.indigo,
                );
                gameCards.add(gameCard);
                for (var game in games) {
                  final gameName = game.data['name'];
                  final gameID = game.documentID;
                  final gameCard = GameListCard(
                    text: gameName,
                    onTap: () {
                      selectedGame = gameID;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsScreen(
                          gameID: selectedGame,
                        );
                      }));
                    },
                    color: kBottomContainerColour,
                  );
                  gameCards.add(gameCard);
                }

                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    children: gameCards,
                  ),
                );
              },
            ),
            BottomButton(
              buttonTitle: 'Start a New Game',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsScreen(
                    gameID: 'new_game',
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
