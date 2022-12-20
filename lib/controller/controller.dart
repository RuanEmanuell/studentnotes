import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [""];

  String noteDate = "";

  List notes = [];

  String checkName = "";

  int textNote = 1;

  late int index;

  var imageOption = ImageSource.gallery;

  void createAction() {
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
    if (noteBody[index] is String) {
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
    noteBody.add("");
    notifyListeners();
  }

  void newCheckAction() {
    noteBody.add([checkName, false]);
    notifyListeners();
  }

  void changeCheckAction(index) {
    noteBody[index][1] = !noteBody[index][1];
    notifyListeners();
  }

  void newDrawnAction(drawn) {
    noteBody.add(drawn);
    notifyListeners();
  }

  void newImageAction(image) {
    noteBody.add(image);
    print(noteBody);
    notifyListeners();
  }

  void resetAction() {
    noteName = "";
    noteBody = [""];
    noteDate = "";
    notifyListeners();
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
}
