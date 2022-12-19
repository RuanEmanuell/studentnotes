import 'package:flutter/material.dart';

import '../widgets/general/bigbutton.dart';

class DrawnScreen extends StatelessWidget {
  var image;

  DrawnScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      SafeArea(
        child: Container(
            height: screenHeight,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
            child: Image.memory(image.buffer.asUint8List())),
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
