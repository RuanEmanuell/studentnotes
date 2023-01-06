import 'package:flutter/material.dart';

import '../widgets/general/bigbutton.dart';

class DrawnScreen extends StatelessWidget {
  var drawn;
  var value;

  DrawnScreen({required this.drawn, required this.value});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      SafeArea(
        child: Container(
            height: screenHeight,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
            child: Image.memory(drawn[1].buffer.asUint8List())),
      ),
      SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        child: BigIconButton(
            color: value.noteBody[0][0],
            icon: Icons.close,
            onPressed: () {
              Navigator.pop(context);
            }),
      )),
    ]));
  }
}
