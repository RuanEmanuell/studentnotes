import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/notecontroller.dart';
import '../../models/appcolors.dart';
import '../../screens/settings.dart';

class NoteAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteController>(
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
    return Consumer<NoteController>(
      builder: (context, value, child) => AppBar(
          backgroundColor: appColors[value.mode][0],
          elevation: 0,
          centerTitle: true,
          title: Text("StudentNotes", style: TextStyle(color: appColors[value.mode][2])),
          leading: InkWell(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.all(screenHeight / 100),
                  decoration:
                      BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child:
                        Text("VIP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ))),
          actions: [
            IconButton(
                icon: Icon(Icons.settings, size: 30, color: appColors[value.mode][2]),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                })
          ]),
    );
  }
}

class SettingsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<NoteController>(
      builder: (context, value, child) => AppBar(
          backgroundColor: appColors[value.mode][0],
          elevation: 0,
          centerTitle: true,
          title: Text("Settings", style: TextStyle(color: appColors[value.mode][2])),
          leading: IconButton(
              icon: Icon(Icons.close, size: 30, color: appColors[value.mode][2]),
              onPressed: () {
                Navigator.pop(context);
              })),
    );
  }
}
