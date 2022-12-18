import "package:flutter/material.dart";

class NoteTitle extends StatelessWidget {
  var value;

  NoteTitle({required this.value});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: screenWidth / 25),
        child: TextFormField(
          controller: TextEditingController(text: value.noteName),
          decoration: const InputDecoration(
              labelText: "Note Title",
              labelStyle: TextStyle(color: Colors.brown),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none),
          style: const TextStyle(fontSize: 25),
          onChanged: (newValue) {
            value.noteName = newValue;
          },
        ),
      ),
    );
  }
}
