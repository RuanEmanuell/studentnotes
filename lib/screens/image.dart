import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  var image;

  ImageScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 238, 88),
              border: Border.all(
                color: Colors.black,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
              icon: const Icon(Icons.close, size: 30),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
    ]));
  }
}
