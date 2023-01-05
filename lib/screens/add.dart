import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'dart:typed_data';

import '../controller/audiocontroller.dart';
import "../controller/controller.dart";

import '../widgets/general/appbar.dart';
import '../widgets/general/delete.dart';
import '../widgets/general/bigbutton.dart';
import '../widgets/notescreen/audiocircle.dart';
import '../widgets/notescreen/audionote.dart';
import '../widgets/notescreen/imagetype.dart';
import '../widgets/notescreen/bottombar.dart';
import '../widgets/notescreen/bottomitem.dart';
import '../widgets/notescreen/checkdialog.dart';
import '../widgets/notescreen/checknote.dart';
import '../widgets/notescreen/drawnbox.dart';
import '../widgets/notescreen/imagebox.dart';
import '../widgets/notescreen/notetitle.dart';
import '../widgets/notescreen/textnote.dart';

import 'paint.dart';
import "home.dart";
import 'drawn.dart';
import "image.dart";

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        backgroundColor: controller.noteBody[0][0],
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 12), child: CustomAppBar(value: controller)),
        body: Consumer<Controller>(
            builder: ((context, value, child) => Column(
                  children: [
                    NoteTitle(value: value),
                    Container(
                      height: screenHeight / 1.6,
                      child: ListView.builder(
                        itemCount: value.noteBody.length,
                        itemBuilder: (context, index) {
                          return value.noteBody[index][0] == "text"
                              ? Row(children: [
                                  TextNote(value: value, index: index),
                                  if (value.textNote > 1)
                                    DeleteButton(onPressed: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      value.removeAction(index);
                                    })
                                ])
                              : value.noteBody[index][0] == "check"
                                  ? Row(children: [
                                      CheckNote(value: value, index: index),
                                      SizedBox(width: screenWidth / 25),
                                      DeleteButton(onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        value.removeAction(index);
                                      }),
                                    ])
                                  : value.noteBody[index][0] == "drawn"
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DrawnScreen(drawn: value.noteBody[index])));
                                          },
                                          child: Row(children: [
                                            DrawnNote(value: value, index: index),
                                            DeleteButton(onPressed: () {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              value.removeAction(index);
                                            }),
                                          ]))
                                      : value.noteBody[index][0] == "image"
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageScreen(image: value.noteBody[index])));
                                              },
                                              child: Row(children: [
                                                ImageNote(value: value, index: index),
                                                DeleteButton(onPressed: () {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  value.removeAction(index);
                                                }),
                                              ]))
                                          : value.noteBody[index][0] == "audio"
                                              ? Row(children: [
                                                  AudioNote(value: value, index: index),
                                                  DeleteButton(onPressed: () {
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                    value.removeAction(index);
                                                  }),
                                                ])
                                              : Container();
                        },
                      ),
                    ),
                  ],
                ))),
        bottomNavigationBar: Container(
          color: controller.noteBody[0][1],
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
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                  height: screenHeight / 3,
                                  width: screenWidth,
                                  child: Row(children: [
                                    ImageTypeBox(
                                      icon: Icons.camera_alt,
                                      text: "Camera",
                                      color: Colors.yellow[200],
                                      onTap: () {
                                        controller.imageOption = ImageSource.camera;
                                        controller.getImage();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ImageTypeBox(
                                      icon: Icons.photo,
                                      text: "Gallery",
                                      color: const Color.fromARGB(255, 255, 238, 88),
                                      onTap: () {
                                        controller.imageOption = ImageSource.gallery;
                                        controller.getImage();
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]));
                            });
                      }),
                  Consumer<AudioController>(
                    builder: (context, value, child) => BottomBarItem(
                        icon: Icons.mic,
                        color: Colors.black,
                        onPressed: () async {
                          value.initPlayerAndRecorder();
                          showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: ((context, setState) => Container(
                                      height: screenHeight / 3,
                                      width: screenWidth,
                                      color: Colors.yellow[200],
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: BottomBar(
                                                child: Center(
                                                    child: Text(value.audioDuration,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold)))),
                                          ),
                                          Expanded(
                                            child: Row(children: [
                                              AudioCircle(
                                                  radius: screenWidth / 20,
                                                  backgroundColor:
                                                      const Color.fromARGB(255, 248, 113, 103),
                                                  icon: const Icon(Icons.close,
                                                      size: 25, color: Colors.white),
                                                  onPressed: () => value.recorderCloseHandler(context)),
                                              AudioCircle(
                                                  radius: screenWidth / 10,
                                                  backgroundColor:
                                                      value.recording ? Colors.red : Colors.blue,
                                                  icon: Icon(value.recording ? Icons.stop : Icons.mic,
                                                      color: Colors.white, size: 30),
                                                  onPressed: () =>
                                                      value.recorderStartStopHandler(setState, context)),
                                              AudioCircle(
                                                  radius: screenWidth / 20,
                                                  backgroundColor:
                                                      value.recording ? Colors.blue : Colors.grey,
                                                  icon: Icon(
                                                      value.paused ? Icons.play_arrow : Icons.pause,
                                                      color: Colors.white,
                                                      size: 25),
                                                  onPressed: () => value.recorderPauseHandler(setState)),
                                            ]),
                                          ),
                                        ],
                                      ))),
                                );
                              });
                        }),
                  ),
                  Consumer<Controller>(
                    builder: (context, value, child) => BottomBarItem(
                        icon: Icons.palette,
                        color: Colors.black,
                        onPressed: () {
                          value.changeColor();
                        }),
                  )
                ],
              )),
              BigIconButton(
                  color: const Color.fromARGB(255, 255, 238, 88),
                  icon: Icons.check,
                  onPressed: () {
                    controller.createAction();
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
