import 'dart:io';

import 'package:alarme/models/colors.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'audiocontroller.dart';

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [];

  String noteDate = "";

  List notes = [];

  String checkName = "";

  int textNote = 1;

  late int index;

  var imageOption = ImageSource.gallery;

  final ScrollController controller = ScrollController();

  void createAction() {
    noteDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notes.add([noteName, noteBody, noteDate]);
    notifyListeners();
  }

  void loadNoteAction(index) {
    noteName = notes[index][0];
    noteBody = notes[index][1];
    notifyListeners();
  }

  void editAction(index) {
    notes[index][0] = noteName;
    notes[index][1] = noteBody;
    notes[index][2] = noteDate;
    notifyListeners();
  }

  void removeAction(index) {
    if (noteBody[index][1] is String && noteBody[index].length == 2) {
      textNote--;
    }
    noteBody.remove(noteBody[index]);
    notifyListeners();
  }

  void removeFullNoteAction(index) {
    notes.remove(notes[index]);
    notifyListeners();
  }

  void newTextAction() {
    textNote++;
    noteBody.add(["text", ""]);
    scrollToNewNote();
    notifyListeners();
  }

  void newCheckAction() {
    noteBody.add(["check", checkName, false]);
    scrollToNewNote();
    notifyListeners();
  }

  void changeCheckAction(index) {
    noteBody[index][2] = !noteBody[index][2];
    scrollToNewNote();
    notifyListeners();
  }

  void newDrawnAction(drawn) {
    noteBody.add(["drawn", drawn]);
    scrollToNewNote();
    notifyListeners();
  }

  void newImageAction(image) {
    noteBody.add(["image", image]);
    scrollToNewNote();
    notifyListeners();
  }

  void newAudioAction(audio, duration, rawDuration, paused) {
    noteBody.add(["audio", audio, duration, rawDuration, paused]);
    scrollToNewNote();
    notifyListeners();
  }

  void pauseAudioIndicator(index) {
    noteBody[index][4] = !noteBody[index][4];
    notifyListeners();
  }

  void resetAction() {
    noteName = "";
    noteBody = [
      colors[0],
      ["text", ""]
    ];
    noteDate = "";
    print(noteBody[0]);
    notifyListeners();
  }

  void changeColor(colorNumber) {
    noteBody[0] = colors[colorNumber];
    notifyListeners();
  }

  void audioPauseHandler(index, context) {
    if (noteBody[index][4] == false) {
      Provider.of<AudioController>(context, listen: false).play(noteBody[index][1]);
    } else {
      Provider.of<AudioController>(context, listen: false).stopPlayer();
    }

    Future.delayed(Duration(milliseconds: noteBody[index][3]), () {
      if (noteBody[index][4] == true) {
        pauseAudioIndicator(index);
      }
    });

    pauseAudioIndicator(index);
  }

  void getImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: imageOption,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      newImageAction(imageFile);
    }
  }

  void scrollToNewNote() {
    controller.animateTo(
      controller.position.maxScrollExtent * 2,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 750),
    );
  }
}
