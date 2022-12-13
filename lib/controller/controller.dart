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

  @action
  void createAction() {
    notes[0].add(noteName);
    notes[1].add(noteBody);
    print(notes);
  }
}
