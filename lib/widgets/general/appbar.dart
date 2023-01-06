import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/maincontroller.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) => AppBar(
          backgroundColor: value.noteBody[0][1],
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              })),
    );
  }
}
