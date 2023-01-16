import 'package:flutter/material.dart';

class BallonText extends StatelessWidget {
  var text;
  var fontSize;
  var color;

  BallonText({required this.text, required this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    color == null ? color = Colors.black : false;
    return Text(text,
        overflow: TextOverflow.ellipsis, style: TextStyle(color: color, fontSize: fontSize));
  }
}
