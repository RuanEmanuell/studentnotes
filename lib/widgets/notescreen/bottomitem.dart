import "package:flutter/material.dart";

class BottomBarItem extends StatelessWidget {
  var icon;
  var onPressed;
  var color;

  BottomBarItem({required this.icon, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(icon: Icon(icon, size: 30, color: color), onPressed: onPressed),
    );
  }
}
