// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on _Controller, Store {
  late final _$noteNameAtom = Atom(name: '_Controller.noteName', context: context);

  @override
  String get noteName {
    _$noteNameAtom.reportRead();
    return super.noteName;
  }

  @override
  set noteName(String value) {
    _$noteNameAtom.reportWrite(value, super.noteName, () {
      super.noteName = value;
    });
  }

  late final _$noteBodyAtom = Atom(name: '_Controller.noteBody', context: context);

  @override
  String get noteBody {
    _$noteBodyAtom.reportRead();
    return super.noteBody;
  }

  @override
  set noteBody(String value) {
    _$noteBodyAtom.reportWrite(value, super.noteBody, () {
      super.noteBody = value;
    });
  }

  late final _$notesAtom = Atom(name: '_Controller.notes', context: context);

  @override
  List<dynamic> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(List<dynamic> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$indexAtom = Atom(name: '_Controller.index', context: context);

  @override
  dynamic get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(dynamic value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$_ControllerActionController = ActionController(name: '_Controller', context: context);

  @override
  void createAction() {
    final _$actionInfo = _$_ControllerActionController.startAction(name: '_Controller.createAction');
    try {
      return super.createAction();
    } finally {
      _$_ControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editAction() {
    final _$actionInfo = _$_ControllerActionController.startAction(name: '_Controller.editAction');
    try {
      return super.editAction();
    } finally {
      _$_ControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAction() {
    final _$actionInfo = _$_ControllerActionController.startAction(name: '_Controller.removeAction');
    try {
      return super.removeAction();
    } finally {
      _$_ControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteName: ${noteName},
noteBody: ${noteBody},
notes: ${notes},
index: ${index}
    ''';
  }
}
