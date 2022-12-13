import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../main.dart';
import 'add.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        body: Column(children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.notes[0].length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.all(40),
                    child: Column(children: [
                      Observer(builder: (context) => Text(controller.notes[0][index])),
                      Observer(builder: (context) => Text(controller.notes[1][index])),
                    ]));
              },
            ),
          ),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScreen(),
                    ));
              })
        ]));
  }
}
