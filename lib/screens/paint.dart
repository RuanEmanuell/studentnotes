import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import 'package:provider/provider.dart';

import '../controller/controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _MyHomePageState extends State<MyHomePage> {
  ByteData _img = ByteData(0);
  var color = 0;
  var colorChanger = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 7),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Signature(
              color: colorChanger,
              key: _sign,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.yellow[200],
          padding: MediaQuery.of(context).viewInsets,
          child: Row(
            children: [
              Container(
                  height: screenHeight / 12,
                  width: screenWidth / 1.4,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.palette, size: 30),
                            onPressed: () {
                              setState(() {
                                color < 3 ? color++ : color = 0;
                                switch (color) {
                                  case 0:
                                    colorChanger = Colors.red;
                                    break;
                                  case 1:
                                    colorChanger = Colors.blue;
                                    break;
                                  case 2:
                                    colorChanger = Colors.green;
                                    break;
                                  case 3:
                                    colorChanger = Colors.yellow;
                                    break;
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.draw_outlined, size: 30),
                            onPressed: () {
                              setState(() {
                                int min = 1;
                                int max = 10;
                                int selection = min + (Random().nextInt(max - min));
                                strokeWidth = selection.roundToDouble();
                                debugPrint("change stroke width to $selection");
                              });
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.replay, size: 30),
                            onPressed: () {
                              final sign = _sign.currentState;
                              sign!.clear();
                              setState(() {
                                _img = ByteData(0);
                              });
                            }),
                      ),
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 238, 88),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                    icon: const Icon(Icons.save, size: 30),
                    onPressed: () async {
                      final sign = _sign.currentState;
                      //retrieve image data, do whatever you want with it (send to server, save locally...)
                      final image = await sign!.getData();
                      var data = await image.toByteData(format: ui.ImageByteFormat.png);
                      sign.clear();
                      final encoded = base64.encode(data!.buffer.asUint8List());
                      setState(() {
                        _img = data;
                      });
                      Provider.of<Controller>(context, listen: false).newImage(_img);
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ));
  }
}
