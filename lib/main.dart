import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'controller/audiocontroller.dart';
import 'controller/notecontroller.dart';
import 'controller/paintcontroller.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteController()),
    ChangeNotifierProvider(create: (context) => PaintController()),
    ChangeNotifierProvider(create: (context) => AudioController())
  ], child: MaterialApp(home: HomeScreen())));
}
