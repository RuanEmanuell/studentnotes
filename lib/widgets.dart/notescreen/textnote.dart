import "package:flutter/material.dart";

class TextNote extends StatelessWidget {
  var value;
  var i;

  TextNote({required this.value, required this.i});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: screenWidth / 25),
      width: screenWidth / 1.2,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: TextEditingController(text: value.noteBody[i]),
        decoration: const InputDecoration(
            labelText: "Your note here...",
            labelStyle: TextStyle(color: Colors.brown),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none),
        onChanged: (newValue) {
          value.noteBody[i] = newValue;
        },
      ),
    );
  }
}
