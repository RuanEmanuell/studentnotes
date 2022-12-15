import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [""];

  String noteDate = "";

  List<dynamic> notes = [];

  int textNote = 1;
  int drawNote = 0;
  int photoNote = 0;
  int audioNote = 0;

  var index;

  void createAction() {
    notes.add([noteName, noteBody, noteDate]);
    notifyListeners();
  }

  void loadNoteAction(index) {
    textNote = notes[index][1].length;
    noteName = notes[index][0];
    noteBody = notes[index][1];
    notifyListeners();
  }

  void editAction(index) {
    notes[index][0] = noteName;
    notes[index][1] = noteBody;
    notifyListeners();
  }

  void removeSingleNoteAction(index) {
    noteBody.remove(noteBody[index]);
    textNote--;
    print(noteBody);
    notifyListeners();
  }

  void removeFullNoteAction(index) {
    notes.remove(notes[index]);
    notifyListeners();
  }

  void newNoteAction() {
    textNote++;
    noteBody.add("");
    notifyListeners();
  }

  void resetAction() {
    noteName = "";
    noteBody = [[]];
    noteDate = "";
    textNote = 1;
    drawNote = 0;
    photoNote = 0;
    audioNote = 0;
    notifyListeners();
  }
}
