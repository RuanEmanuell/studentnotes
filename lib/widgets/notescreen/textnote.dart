import "package:flutter/material.dart";

import '../../models/applanguages.dart';

class TextNote extends StatelessWidget {
  var value;
  var index;

  TextNote({required this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: screenWidth / 25),
      width: screenWidth / 1.2,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: TextEditingController(text: value.noteBody[index][1]),
        decoration: InputDecoration(
            labelText: languages[value.languages[value.language]]["textnote"],
            labelStyle: TextStyle(color: Colors.brown),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none),
        onChanged: (newValue) {
          value.noteBody[index][1] = newValue;
        },
      ),
    );
  }
}
