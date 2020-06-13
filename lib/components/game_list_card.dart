import 'package:flutter/material.dart';
import 'package:ttsc/constants.dart';

class GameListCard extends StatelessWidget {
  GameListCard({@required this.text, this.onTap, this.color});
  //@required this.onTap,
  final Function onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: kGameCardStyle,
          ),
        ),
        //color: kBottomContainerColour,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.all(10),
        width: double.infinity,

        //height: kBottomContainerHeight,
      ),
    );
  }
}
