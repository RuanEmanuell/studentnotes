import 'package:flutter/material.dart';

import '../widgets/general/bigbutton.dart';

class ImageScreen extends StatelessWidget {
  var image;
  var value;

  ImageScreen({required this.image, required this.value});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: value.noteBody[0][1],
        body: Stack(children: [
          SafeArea(
            child: Center(
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
                  child: Image.file(image[1])),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 3),
              child: BigIconButton(
                  color: value.noteBody[0][0],
                  icon: Icons.close,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          )
        ]));
  }
}
