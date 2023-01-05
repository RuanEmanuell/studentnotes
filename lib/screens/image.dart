import 'package:flutter/material.dart';

import '../widgets/general/bigbutton.dart';

class ImageScreen extends StatelessWidget {
  var image;

  ImageScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      SafeArea(
        child: Container(
            height: screenHeight,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
            child: Image.file(image[1])),
      ),
      SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        child: BigIconButton(
            color: const Color.fromARGB(255, 255, 238, 88),
            icon: Icons.close,
            onPressed: () {
              Navigator.pop(context);
            }),
      )),
    ]));
  }
}
