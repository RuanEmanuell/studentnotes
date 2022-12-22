import "package:flutter/material.dart";

class AudioCircle extends StatelessWidget {
  var radius;
  var backgroundColor;
  var icon;
  var onPressed;

  AudioCircle(
      {required this.radius,
      required this.backgroundColor,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    ));
  }
}
