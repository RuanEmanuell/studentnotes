import 'package:alarme/models/appcolors.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/interfacecontroller.dart';

class SettingsBox extends StatelessWidget {
  var settings;
  var selectedOption;

  SettingsBox({required this.settings, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<InterfaceController>(
      builder: (context, value, child) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
              color: appColors[0][1],
              height: settings.length == 3 ? screenHeight / 2.3 : screenHeight / 2.75,
              width: screenWidth / 2,
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text("Language",
                      style: TextStyle(
                          color: appColors[0][2],
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 20)),
                ),
                for (var i = 0; i < settings.length; i++)
                  ListTile(
                      title: Text(settings[i], style: TextStyle(color: appColors[0][2])),
                      leading: Radio(
                          value: i,
                          groupValue: value.mode,
                          activeColor: Colors.blue,
                          onChanged: ((newValue) {
                            setState(() {
                              value.changeMode(i);
                            });
                          }))),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child:
                        Text("SELECT", style: TextStyle(color: Colors.blue, fontSize: screenWidth / 20)),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
