import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/maincontroller.dart';

class NoteAppBar extends StatelessWidget {
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

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("StudentNotes", style: TextStyle(color: Colors.black)),
        leading: InkWell(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.all(screenHeight / 100),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 216, 41), borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text("VIP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ))),
        actions: [
          IconButton(icon: const Icon(Icons.settings, size: 30, color: Colors.black), onPressed: () {})
        ]);
  }
}
