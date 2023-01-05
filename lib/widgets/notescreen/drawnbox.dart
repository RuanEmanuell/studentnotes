import "package:flutter/material.dart";

class DrawnNote extends StatelessWidget {
  var value;
  var index;

  DrawnNote({required this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(left: screenWidth / 25, top: screenHeight / 50),
        decoration:
            BoxDecoration(color: Colors.white, border: Border.all(width: 3, color: Colors.black)),
        height: screenHeight / 2.5,
        width: screenWidth / 1.2,
        child: Image.memory(value.noteBody[index].buffer.asUint8List()));
  }
}
