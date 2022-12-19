import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.yellow[200],
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }));
  }
}
