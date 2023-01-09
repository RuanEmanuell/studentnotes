import "package:flutter/material.dart";

class BigIconButton extends StatelessWidget {
  var color;
  var icon;
  var onPressed;
  var iconColor;

  BigIconButton(
      {required this.onPressed, required this.icon, required this.color, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: IconButton(icon: Icon(icon, size: 30, color: iconColor), onPressed: onPressed),
    );
  }
}
