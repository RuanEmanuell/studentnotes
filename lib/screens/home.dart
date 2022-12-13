import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../main.dart';
import 'add.dart';
import 'note.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        body: Column(children: [
          SizedBox(
            height: screenHeight / 1.1,
            child: Observer(
              builder: (context) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notes[0].length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Observer(
                          builder: (context) => InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => NoteScreen(index: index)));
                            },
                            child: Container(
                                width: screenWidth / 1.6,
                                margin: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                child: Column(children: [
                                  Text(controller.notes[0][index]),
                                  Text(controller.notes[1][index])
                                ])),
                          ),
                        ),
                        Container(
                          child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                controller.index = index;
                                controller.removeAction();
                              }),
                        )
                      ],
                    );
                  }),
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
