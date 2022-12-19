import "package:flutter/material.dart";

class BottomBar extends StatelessWidget {
  var child;

  BottomBar({required this.child});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight / 12,
        width: screenWidth / 1.4,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.5),
            borderRadius: BorderRadius.circular(20)),
        child: child);
  }
}
