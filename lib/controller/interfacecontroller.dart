import "package:flutter/material.dart";

class InterfaceController extends ChangeNotifier {
  var languages = ["English", "Português", "Español"];
  var language = 0;

  var modes = ["Light Mode", "Dark Mode"];
  var mode = 0;

  var notifications = ["On", "Off"];
  var notification = 0;

  var selectedOption = 0;

  void changeOption(i) {
    selectedOption = i;
    print(selectedOption);
    notifyListeners();
  }
}
