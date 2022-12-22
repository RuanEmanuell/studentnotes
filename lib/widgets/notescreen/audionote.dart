import "package:flutter/material.dart";

class AudioNote extends StatelessWidget{

  var value;
  var i;

  AudioNote({
    required this.value, required this.i
  });

  @override
  Widget build(BuildContext context){
        var screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children:[
                            IconButton(
                                icon: Icon(
                                    value.noteBody[i][3] == false ? Icons.play_arrow : Icons.pause,
                                    color: value.noteBody[i][3] == false ? Colors.black : Colors.blue),
                                onPressed: () => value.audioPauseHandler(i, context)),
                            Container(
                                height: 5,
                                width: screenWidth / 1.6,
                                color: value.noteBody[i][3] == false ? Colors.black : Colors.blue),
                            SizedBox(width: screenWidth / 20),
                            Text(value.noteBody[i][1].toString()),
      ]
    );
  }
}