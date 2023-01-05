import "package:flutter/material.dart";

class ColorCircle extends StatelessWidget {
  var colors;
  var i;

  ColorCircle({required this.colors, required this.i});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.all(screenWidth / 30),
        height: screenHeight / 17,
        width: screenWidth / 10,
        decoration: BoxDecoration(
            color: colors[i],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(100)));
  }
}

class PencilCircle extends StatelessWidget {
  var i;
  var controller;

  PencilCircle({required this.i, required this.controller});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.all(screenWidth / 30),
        height: screenHeight / 17,
        width: screenWidth / 10,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: controller.noteBody[0][1], width: i * 1.75),
          borderRadius: BorderRadius.circular(100),
        ));
  }
}
