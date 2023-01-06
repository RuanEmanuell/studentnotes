import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/audiocontroller.dart';
import 'controller/maincontroller.dart';
import 'controller/paintcontroller.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Controller()),
    ChangeNotifierProvider(create: (context) => PaintController()),
    ChangeNotifierProvider(create: (context) => AudioController())
  ], child: MaterialApp(home: HomeScreen())));
}
