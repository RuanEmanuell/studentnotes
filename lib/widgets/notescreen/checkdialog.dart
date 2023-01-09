import 'package:flutter/material.dart';

class CheckDialog extends StatelessWidget {
  var value;

  CheckDialog({required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Choose a name to your check box", style: TextStyle(color: Colors.black)),
        backgroundColor: value.noteBody[0][1],
        content: TextField(onChanged: (newValue) {
          value.checkName = newValue;
        }),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: value.noteBody[0][0],
                  shape:
                      const RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 2.5))),
              onPressed: () {
                if (value.checkName.isNotEmpty) {
                  value.newCheckAction();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add check", style: TextStyle(color: Colors.black)))
        ]);
  }
}
