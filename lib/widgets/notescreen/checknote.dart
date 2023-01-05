import 'package:flutter/material.dart';

class CheckNote extends StatelessWidget {
  var value;
  var index;

  CheckNote({required this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: screenWidth / 1.2,
        child: CheckboxListTile(
          title: Text(value.noteBody[index][1]),
          value: value.noteBody[index][2],
          onChanged: (newValue) {
            value.changeCheckAction(index);
          },
        ));
  }
}
