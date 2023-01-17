import 'dart:io';

import 'package:alarme/models/notecolors.dart';
import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'audiocontroller.dart';

class NoteController extends ChangeNotifier {
  //////////////Notes variables

  String noteName = "";

  List noteBody = [];

  String noteDate = "";

  List notes = [];

  String checkName = "";

  int textNote = 1;

  var imageOption = ImageSource.gallery;

  late ScrollController scrollController;

  //////////////Notes functions

  void createAction() {
    noteDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notes.add([noteName, noteBody, noteDate]);
    updateDatabase();
    notifyListeners();
  }

  void loadNoteAction(index) {
    noteName = notes[index][0];
    noteBody = notes[index][1];
    updateDatabase();
    notifyListeners();
  }

  void editAction(index) {
    notes[index][0] = noteName;
    notes[index][1] = noteBody;
    notes[index][2] = noteDate;
    updateDatabase();
    notifyListeners();
  }

  void removeAction(index) {
    notes.remove(notes[index]);
    updateDatabase();
    notifyListeners();
  }

  void resetAction() {
    noteName = "";
    noteBody = [
      noteColors[0],
      ["text", ""]
    ];
    noteDate = "";
    notifyListeners();
  }

  void removeSingleNoteAction(index) {
    if (noteBody[index][1] is String && noteBody[index].length == 2) {
      textNote--;
    }
    noteBody.remove(noteBody[index]);
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

  void changeColor(colorNumber) {
    noteBody[0] = noteColors[colorNumber];
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
    scrollController.animateTo(
      scrollController.position.maxScrollExtent * 3,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 750),
    );
  }

  //////////////App language, colors and notifications controllers

  var languages = ["English", "Português", "Español"];
  var language = 0;

  var modes = ["Light Mode", "Dark Mode"];
  var mode = 0;

  var notifications = ["On", "Off"];
  var notification = 0;

  void changeMode(i) {
    mode = i;
    notifyListeners();
  }

  void changeLanguage(i) {
    language = i;
    notifyListeners();
  }

  void changeNotification(i) {
    notification = i;
    notifyListeners();
  }

  //Data controller
  void openBox() async {
    await Hive.openBox("notebox");
    if (Hive.box("notebox").isNotEmpty) {
      notes = Hive.box("notebox").get("notelist");
    } else {
      notes = [];
    }
  }

  void updateDatabase() async {
    await Hive.box("notebox").put("notelist", notes);
  }
}
