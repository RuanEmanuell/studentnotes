import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  String noteName = "";

  List noteBody = [[], []];

  late String noteDate;

  List<dynamic> notes = [[], [], []];

  List textNote = ["note"];
  List drawNote = [];
  List photoNote = [];
  List audioNote = [];

  var index;

  void createAction() {
    noteDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notes[0].add(noteName);
    notes[1].add(noteBody);
    notes[2].add(noteDate);
    notifyListeners();
  }

  void editAction(index) {
    notes[0][index] = noteName;
    notes[1][index] = noteBody;
    notifyListeners();
  }

  void removeAction(index) {
    notes[0].remove(notes[0][index]);
    notes[1].remove(notes[1][index]);
    notifyListeners();
  }

  void newNoteAction() {
    textNote.add("note");
    notifyListeners();
  }
}
