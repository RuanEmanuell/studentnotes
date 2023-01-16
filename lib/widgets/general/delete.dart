import "package:flutter/material.dart";

class DeleteButton extends StatelessWidget {
  var onPressed;
  var color;

  DeleteButton({required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    color == null ? color = Colors.black : false;
    return IconButton(icon: Icon(Icons.delete, size: 30, color: color), onPressed: onPressed);
  }
}
