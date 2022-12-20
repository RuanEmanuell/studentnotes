import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:typed_data';

import "../controller/controller.dart";

import '../widgets/general/appbar.dart';
import '../widgets/general/delete.dart';
import '../widgets/general/bigbutton.dart';
import '../widgets/notescreen/bottombar.dart';
import '../widgets/notescreen/bottomitem.dart';
import '../widgets/notescreen/checkdialog.dart';
import '../widgets/notescreen/checknote.dart';
import '../widgets/notescreen/drawnbox.dart';
import '../widgets/notescreen/imagebox.dart';
import '../widgets/notescreen/notetitle.dart';
import '../widgets/notescreen/textnote.dart';

import 'image.dart';
import 'paint.dart';
import "home.dart";
import 'drawn.dart';

class EditScreen extends StatelessWidget {
  var index;

  EditScreen({required this.index});

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
                                value.removeAction(i);
                              })
                          ])
                        else if (value.noteBody[i].length == 2)
                          Row(children: [
                            CheckNote(value: value, i: i),
                            SizedBox(width: screenWidth / 25),
                            DeleteButton(onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              value.removeAction(i);
                            }),
                          ])
                        else if (value.noteBody[i] is ByteData)
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DrawnScreen(drawn: value.noteBody[i])));
                              },
                              child: Row(children: [
                                DrawnNote(value: value, i: i),
                                DeleteButton(onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  value.removeAction(i);
                                }),
                              ]))
                        else if (value.noteBody[i] is File)
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageScreen(image: value.noteBody[i])));
                              },
                              child: Row(children: [
                                ImageNote(value: value, i: i),
                                DeleteButton(onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  value.removeAction(i);
                                }),
                              ]))
                    ],
                  ))),
        ),
        bottomNavigationBar: Container(
          color: Colors.yellow[200],
          padding: MediaQuery.of(context).viewInsets,
          child: Row(
            children: [
              BottomBar(
                  child: Row(
                children: [
                  BottomBarItem(
                      icon: Icons.abc,
                      color: Colors.black,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.newTextAction();
                      }),
                  BottomBarItem(
                      icon: Icons.check_box,
                      color: Colors.black,
                      onPressed: () {
                        controller.checkName = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CheckDialog(controller: controller);
                          },
                        );
                      }),
                  BottomBarItem(
                      icon: Icons.draw,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PaintScreen();
                          },
                        ));
                      }),
                  BottomBarItem(
                      icon: Icons.add_a_photo,
                      color: Colors.black,
                      onPressed: () {
                        controller.getImage();
                      }),
                  BottomBarItem(icon: Icons.mic, color: Colors.grey, onPressed: () {})
                ],
              )),
              BigIconButton(
                  color: const Color.fromARGB(255, 255, 238, 88),
                  icon: Icons.check,
                  onPressed: () {
                    controller.noteDate =
                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                    controller.editAction(index);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  })
            ],
          ),
        ));
  }
}
