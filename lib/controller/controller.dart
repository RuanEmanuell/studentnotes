import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [];

  String noteDate = "";

  List<dynamic> notes = [];

  int textNote = 1;
  int drawNote = 0;
  int photoNote = 0;
  int audioNote = 0;

  var titleController;
  var noteController;

  var index;

  void createAction() {
    notes.add([noteName, noteBody, noteDate]);
    print(notes);
    notifyListeners();
  }

  void editAction(index) {
    notes[0][index] = noteName;
    notes[1][index] = noteBody;
    notifyListeners();
  }

  void removeAction(index) {
    notes.remove(notes[index]);
    print(notes);
    notifyListeners();
  }

  void newNoteAction() {
    textNote++;
    notifyListeners();
  }

  void resetAction() {
    titleController.text = "";
    noteController.text = "";
    noteName = "";
    noteBody = [];
    noteDate = "";
    textNote = 1;
    drawNote = 0;
    photoNote = 0;
    audioNote = 0;
    notifyListeners();
  }
}
