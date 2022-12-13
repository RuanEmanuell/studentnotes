import 'package:alarme/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import "home.dart";

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        body: Column(
          children: [
            Observer(
                builder: (context) => TextField(
                      decoration: const InputDecoration(
                          labelText: "Note Title",
                          labelStyle: TextStyle(color: Colors.brown),
                          border: InputBorder.none),
                      onChanged: (value) {
                        controller.noteName = value;
                      },
                    )),
            Observer(
                builder: (context) => TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "Your note here...",
                          labelStyle: TextStyle(color: Colors.brown),
                          border: InputBorder.none),
                      onChanged: (value) {
                        controller.noteBody = value;
                      },
                    )),
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  controller.createAction();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                })
          ],
        ));
  }
}
