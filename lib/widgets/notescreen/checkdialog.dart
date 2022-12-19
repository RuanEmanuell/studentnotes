import 'package:flutter/material.dart';

class CheckDialog extends StatelessWidget {
  var controller;

  CheckDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Choose a name to your check box", style: TextStyle(color: Colors.brown)),
        backgroundColor: Colors.yellow[200],
        content: TextField(onChanged: (newValue) {
          controller.checkName = newValue;
        }),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 238, 88),
                  shape:
                      const RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 2.5))),
              onPressed: () {
                if (controller.checkName.isNotEmpty) {
                  controller.newCheckAction();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add check", style: TextStyle(color: Colors.black)))
        ]);
  }
}
