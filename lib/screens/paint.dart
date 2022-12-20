import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../controller/paintcontroller.dart';
import '../widgets/general/appbar.dart';
import '../widgets/general/bigbutton.dart';
import '../widgets/notescreen/bottombar.dart';
import '../widgets/notescreen/bottomitem.dart';
import '../widgets/paintscreen/itemcircle.dart';

class PaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: CustomAppBar()),
        body: Consumer<PaintController>(
            builder: (context, value, child) => (Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 7),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Signature(
                      color: value.colorChanger,
                      key: value.sign,
                      strokeWidth: value.strokeWidth,
                    ),
                  ),
                ))),
        bottomNavigationBar: Consumer<PaintController>(
            builder: (context, value, child) => (Container(
                  color: Colors.yellow[200],
                  padding: MediaQuery.of(context).viewInsets,
                  child: Row(
                    children: [
                      BottomBar(
                          child: Row(children: [
                        BottomBarItem(
                            icon: Icons.palette,
                            color: value.colorChanger,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                    height: screenHeight / 5,
                                    child: Wrap(alignment: WrapAlignment.center, children: [
                                      for (var i = 0; i < value.colors.length; i++)
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              value.changeColor(i);
                                            },
                                            child: ColorCircle(colors: value.colors, i: i))
                                    ])),
                              );
                            }),
                        BottomBarItem(
                          icon: Icons.draw_outlined,
                          color: Colors.black,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                  height: screenHeight / 5,
                                  child: Wrap(alignment: WrapAlignment.center, children: [
                                    for (var i = 10; i > 0; i--)
                                      InkWell(
                                          onTap: () {
                                            value.changePencil(i);
                                            Navigator.pop(context);
                                          },
                                          child: PencilCircle(i: i))
                                  ])),
                            );
                          },
                        ),
                        BottomBarItem(
                            icon: Icons.delete,
                            color: Colors.black,
                            onPressed: () {
                              final sign = value.sign.currentState;
                              sign!.clear();
                              value.drawn = ByteData(0);
                            })
                      ])),
                      BigIconButton(
                        color: const Color.fromARGB(255, 255, 238, 88),
                        icon: Icons.save,
                        onPressed: () async {
                          final sign = value.sign.currentState;
                          final image = await sign!.getData();
                          sign.clear();
                          var data = await image.toByteData(format: ui.ImageByteFormat.png);
                          value.drawn = data!;
                          controller.newDrawnAction(value.drawn);
                          FocusManager.instance.primaryFocus?.unfocus();

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ))));
  }
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
