import 'package:flutter/material.dart';
import "screens/add.dart";

import 'controller/controller.dart';

var controller = Controller();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: AddScreen()));
}
