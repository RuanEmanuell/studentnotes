import "package:flutter/material.dart";

class AudioNote extends StatelessWidget {
  var value;
  var index;

  AudioNote({required this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Row(children: [
      IconButton(
          icon: Icon(value.noteBody[index][4] == false ? Icons.play_arrow : Icons.pause,
              color: value.noteBody[index][4] == false ? Colors.black : Colors.white),
          onPressed: () => value.audioPauseHandler(index, context)),
      Container(
          height: 5,
          width: screenWidth / 1.6,
          color: value.noteBody[index][4] == false ? Colors.black : Colors.white),
      SizedBox(width: screenWidth / 20),
      Text(value.noteBody[index][2].toString()),
    ]);
  }
}
