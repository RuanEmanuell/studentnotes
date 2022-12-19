import "package:flutter/material.dart";

class DeleteButton extends StatelessWidget {
  var onPressed;

  DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.delete, size: 30), onPressed: onPressed);
  }
}
