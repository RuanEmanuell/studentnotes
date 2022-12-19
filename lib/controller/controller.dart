import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [""];

  String noteDate = "";

  List notes = [];

  String checkName = "";

  int textNote = 1;

  late int index;

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

  void removeTextAction(index) {
    noteBody.remove(noteBody[index]);
    textNote--;
    notifyListeners();
  }

  void removeCheckAction(index) {
    noteBody.remove(noteBody[index]);
    notifyListeners();
  }

  void removeDrawAction(index) {
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

  void newDrawn(image) {
    noteBody.add(image);
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

  void resetAction() {
    noteName = "";
    noteBody = [""];
    noteDate = "";
    notifyListeners();
  }
}
