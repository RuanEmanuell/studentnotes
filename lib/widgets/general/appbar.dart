import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget {
  var value;

  CustomAppBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: value.noteBody[0][0],
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }));
  }
}
