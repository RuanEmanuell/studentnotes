import "package:flutter/material.dart";

class BottomBarItem extends StatelessWidget {
  var icon;
  var onPressed;

  BottomBarItem({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(icon: Icon(icon, size: 30), onPressed: onPressed),
    );
  }
}
