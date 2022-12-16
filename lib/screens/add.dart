import 'dart:typed_data';

import 'package:alarme/screens/paint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../controller/controller.dart";
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
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
              builder: ((context, value, child) => Column(
                    children: [
                      SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(left: screenWidth / 25),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Note Title",
                                labelStyle: TextStyle(color: Colors.brown),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                border: InputBorder.none),
                            style: const TextStyle(fontSize: 25),
                            onChanged: (newValue) {
                              value.noteName = newValue;
                            },
                          ),
                        ),
                      ),
                      for (var i = 0; i < value.noteBody.length; i++)
                        if (value.noteBody[i].length == 1)
                          Row(children: [
                            Container(
                              margin: EdgeInsets.only(left: screenWidth / 25),
                              width: screenWidth / 1.2,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: TextEditingController(text: value.noteBody[i][0]),
                                decoration: const InputDecoration(
                                    labelText: "Your note here...",
                                    labelStyle: TextStyle(color: Colors.brown),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    border: InputBorder.none),
                                onChanged: (newValue) {
                                  value.noteBody[i][0] = newValue;
                                },
                              ),
                            ),
                            if (value.noteBody.length > 1 && value.noteBody[i][0] is String)
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    value.removeTextAction(i);
                                  }),
                          ])
                        else if (value.noteBody[i].length == 2)
                          Row(children: [
                            SizedBox(
                                width: screenWidth / 1.2,
                                child: CheckboxListTile(
                                  title: Text(value.noteBody[i][0]),
                                  value: value.noteBody[i][1],
                                  onChanged: (newValue) {
                                    value.changeCheckAction(i);
                                  },
                                )),
                            SizedBox(width: screenWidth / 25),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
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
                                    margin: EdgeInsets.only(left: screenWidth / 25),
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
                                      title: const Text("Choose a name to your check box"),
                                      content: TextField(onChanged: (newValue) {
                                        controller.checkName = newValue;
                                      }),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (controller.checkName.isNotEmpty) {
                                                controller.newCheckAction();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Add check"))
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
