import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class Controller = _Controller with _$Controller;

abstract class _Controller with Store {
  @observable
  String noteName = "";

  @observable
  String noteBody = "";

  @observable
  List<dynamic> notes = [[], []];

  @observable
  var index;

  @action
  void createAction() {
    notes[0].add(noteName);
    notes[1].add(noteBody);
    print(notes);
  }

  @action
  void editAction() {
    notes[0][index] = noteName;
    notes[1][index] = noteBody;
    print(notes);
  }

  @action
  void removeAction() {
    notes[0].remove(notes[0][index]);
    notes[1].remove(notes[1][index]);
    print(notes);
  }
}
