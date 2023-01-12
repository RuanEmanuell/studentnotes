import 'package:alarme/models/notecolors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/audiocontroller.dart';
import '../controller/notecontroller.dart';

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

class NoteScreen extends StatelessWidget {
  var index;

  NoteScreen({this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();
    Provider.of<NoteController>(context, listen: false).scrollController = scrollController;
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: NoteAppBar()),
        body: Consumer<NoteController>(
            builder: ((context, value, child) => Container(
                  color: value.noteBody[0][0],
                  child: Column(
                    children: [
                      NoteTitle(value: value),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: value.noteBody.length,
                          itemBuilder: (context, index) {
                            return value.noteBody[index][0] == "text"
                                ? Row(children: [
                                    TextNote(value: value, index: index),
                                    if (value.textNote > 1)
                                      DeleteButton(onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        value.removeSingleNoteAction(index);
                                      })
                                  ])
                                : value.noteBody[index][0] == "check"
                                    ? Row(children: [
                                        CheckNote(value: value, index: index),
                                        SizedBox(width: screenWidth / 25),
                                        DeleteButton(onPressed: () {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          value.removeSingleNoteAction(index);
                                        }),
                                      ])
                                    : value.noteBody[index][0] == "drawn"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => DrawnScreen(
                                                          drawn: value.noteBody[index], value: value)));
                                            },
                                            child: Row(children: [
                                              DrawnNote(value: value, index: index),
                                              DeleteButton(onPressed: () {
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                value.removeSingleNoteAction(index);
                                              }),
                                            ]))
                                        : value.noteBody[index][0] == "image"
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ImageScreen(
                                                              image: value.noteBody[index],
                                                              value: value)));
                                                },
                                                child: Row(children: [
                                                  ImageNote(value: value, index: index),
                                                  DeleteButton(onPressed: () {
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                    value.removeSingleNoteAction(index);
                                                  }),
                                                ]))
                                            : value.noteBody[index][0] == "audio"
                                                ? Row(children: [
                                                    AudioNote(value: value, index: index),
                                                    DeleteButton(onPressed: () {
                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                      value.removeSingleNoteAction(index);
                                                    }),
                                                  ])
                                                : Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ))),
        bottomNavigationBar: Consumer<NoteController>(
            builder: ((context, value, child) => Container(
                  color: value.noteBody[0][1],
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
                                value.newTextAction();
                              }),
                          BottomBarItem(
                              icon: Icons.check_box,
                              color: Colors.black,
                              onPressed: () {
                                value.checkName = "";
                                FocusManager.instance.primaryFocus?.unfocus();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CheckDialog(value: value);
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
                                              color: value.noteBody[0][1],
                                              onTap: () {
                                                value.imageOption = ImageSource.camera;
                                                value.getImage();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ImageTypeBox(
                                              icon: Icons.photo,
                                              text: "Gallery",
                                              color: value.noteBody[0][0],
                                              onTap: () {
                                                value.imageOption = ImageSource.gallery;
                                                value.getImage();
                                                Navigator.pop(context);
                                              },
                                            )
                                          ]));
                                    });
                              }),
                          Consumer<AudioController>(
                            builder: (context, audioValue, child) => BottomBarItem(
                                icon: Icons.mic,
                                color: Colors.black,
                                onPressed: () async {
                                  audioValue.initPlayerAndRecorder();
                                  showModalBottomSheet(
                                      context: context,
                                      isDismissible: false,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: ((context, setState) => Container(
                                              height: screenHeight / 3,
                                              width: screenWidth,
                                              color: value.noteBody[0][1],
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: BottomBar(
                                                        child: Center(
                                                            child: Text(audioValue.audioDuration,
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
                                                          onPressed: () =>
                                                              audioValue.recorderCloseHandler(context)),
                                                      AudioCircle(
                                                          radius: screenWidth / 10,
                                                          backgroundColor: audioValue.recording
                                                              ? Colors.red
                                                              : Colors.blue,
                                                          icon: Icon(
                                                              audioValue.recording
                                                                  ? Icons.stop
                                                                  : Icons.mic,
                                                              color: Colors.white,
                                                              size: 30),
                                                          onPressed: () =>
                                                              audioValue.recorderStartStopHandler(
                                                                  setState, context)),
                                                      AudioCircle(
                                                          radius: screenWidth / 20,
                                                          backgroundColor: audioValue.recording
                                                              ? Colors.blue
                                                              : Colors.grey,
                                                          icon: Icon(
                                                              audioValue.paused
                                                                  ? Icons.play_arrow
                                                                  : Icons.pause,
                                                              color: Colors.white,
                                                              size: 25),
                                                          onPressed: () =>
                                                              audioValue.recorderPauseHandler(setState)),
                                                    ]),
                                                  ),
                                                ],
                                              ))),
                                        );
                                      });
                                }),
                          ),
                          BottomBarItem(
                              icon: Icons.palette,
                              color: Colors.black,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                      color: value.noteBody[0][1],
                                      height: screenHeight / 5,
                                      child: Wrap(alignment: WrapAlignment.center, children: [
                                        for (var i = 0; i < noteColors.length; i++)
                                          InkWell(
                                            onTap: () {
                                              value.changeColor(i);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                margin: EdgeInsets.all(screenWidth / 30),
                                                height: screenHeight / 15.5,
                                                width: screenWidth / 9,
                                                decoration: BoxDecoration(
                                                    color: noteColors[i][0],
                                                    border: Border.all(color: Colors.black, width: 2),
                                                    borderRadius: BorderRadius.circular(100))),
                                          )
                                      ])),
                                );
                              })
                        ],
                      )),
                      BigIconButton(
                          color: value.noteBody[0][0],
                          icon: Icons.check,
                          iconColor: Colors.black,
                          onPressed: () {
                            if (index == null) {
                              value.createAction();
                            } else {
                              value.editAction(index);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          })
                    ],
                  ),
                ))));
  }
}
