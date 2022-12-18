import 'dart:typed_data';

import 'package:alarme/screens/paint.dart';
import '../widgets.dart/general/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../controller/controller.dart";
import '../widgets.dart/general/delete.dart';
import '../widgets.dart/notescreen/checknote.dart';
import '../widgets.dart/notescreen/notetitle.dart';
import '../widgets.dart/notescreen/textnote.dart';
import "home.dart";
import 'image.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: CustomAppBar()),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
              builder: ((context, value, child) => Column(
                    children: [
                      NoteTitle(value: value),
                      for (var i = 0; i < value.noteBody.length; i++)
                        if (value.noteBody[i] is String)
                          Row(children: [
                            TextNote(value: value, i: i),
                            if (value.textNote > 1)
                              DeleteButton(onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                value.removeTextAction(i);
                              })
                          ])
                        else if (value.noteBody[i].length == 2)
                          Row(children: [
                            CheckNote(value: value, i: i),
                            SizedBox(width: screenWidth / 25),
                            if (value.textNote > 1)
                              DeleteButton(onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                value.removeCheckAction(i);
                              }),
                          ])
                        else if (value.noteBody[i] is ByteData)
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageScreen(image: value.noteBody[i])));
                              },
                              child: Row(children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(left: screenWidth / 25, top: screenHeight / 50),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(width: 3, color: Colors.black)),
                                    height: screenHeight / 2.5,
                                    width: screenWidth / 1.2,
                                    child: Image.memory(value.noteBody[i].buffer.asUint8List())),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      value.removeDrawAction(i);
                                    }),
                              ])),
                    ],
                  ))),
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
                            icon: const Icon(Icons.abc, size: 30),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.newTextAction();
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.check_box, size: 30),
                            onPressed: () {
                              controller.checkName = "";
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: const Text("Choose a name to your check box",
                                          style: TextStyle(color: Colors.brown)),
                                      backgroundColor: Colors.yellow[200],
                                      content: TextField(onChanged: (newValue) {
                                        controller.checkName = newValue;
                                      }),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(255, 255, 238, 88),
                                                shape: const RoundedRectangleBorder(
                                                    side: BorderSide(color: Colors.black, width: 2.5))),
                                            onPressed: () {
                                              if (controller.checkName.isNotEmpty) {
                                                controller.newCheckAction();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Add check",
                                                style: TextStyle(color: Colors.black)))
                                      ]);
                                },
                              );
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.draw, size: 30),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MyHomePage();
                                },
                              ));
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.add_a_photo, size: 30, color: Colors.grey),
                            onPressed: () {}),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.mic, size: 30, color: Colors.grey), onPressed: () {}),
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
                    icon: const Icon(Icons.check, size: 30),
                    onPressed: () {
                      controller.noteDate =
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                      controller.createAction();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }),
              ),
            ],
          ),
        ));
  }
}
