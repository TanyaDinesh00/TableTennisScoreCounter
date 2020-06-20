import 'package:flutter/material.dart';
import 'package:ttsc/constants.dart';

class WideButton extends StatelessWidget {
  WideButton({this.onTap, this.text, this.color});

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
            style: kLargeButtonTextStyle,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        margin: EdgeInsets.only(top: 7, bottom: 5, left: 20, right: 20),
        padding: EdgeInsets.all(10),
        //height: kBottomContainerHeight,
      ),
    );
  }
}
