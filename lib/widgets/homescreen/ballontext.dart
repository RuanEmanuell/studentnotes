import 'package:flutter/material.dart';

class BallonText extends StatelessWidget {
  var text;
  var fontSize;

  BallonText({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize));
  }
}
