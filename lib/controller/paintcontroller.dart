import 'dart:typed_data';

import "package:flutter/material.dart";
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class PaintController extends ChangeNotifier {
  ByteData drawn = ByteData(0);
  var color = 0;
  var colorChanger = Colors.black;
  var strokeWidth = 5.0;
  final sign = GlobalKey<SignatureState>();

  List colors = [
    Colors.black,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.green
  ];

  void changeColor(index) {
    colorChanger = colors[index];
    notifyListeners();
  }

  void changePencil(index) {
    strokeWidth = (index - 10).abs().toDouble();
    notifyListeners();
  }
}
