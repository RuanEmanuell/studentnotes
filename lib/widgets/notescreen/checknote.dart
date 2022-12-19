import 'package:flutter/material.dart';

class CheckNote extends StatelessWidget {
  var value;
  var i;

  CheckNote({required this.value, required this.i});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: screenWidth / 1.2,
        child: CheckboxListTile(
          title: Text(value.noteBody[i][0]),
          value: value.noteBody[i][1],
          onChanged: (newValue) {
            value.changeCheckAction(i);
          },
        ));
  }
}
