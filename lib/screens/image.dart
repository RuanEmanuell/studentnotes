import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  var image;

  ImageScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.memory(image.buffer.asUint8List()));
  }
}
