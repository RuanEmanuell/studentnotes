import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../controller/interfacecontroller.dart';
import '../models/appcolors.dart';
import '../widgets/general/appbar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: SettingsAppBar()),
      body: Consumer<InterfaceController>(
        builder: (context, value, child) => Container(
            color: appColors[value.mode][1],
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenWidth / 20),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => Dialog(
                                    child: Container(
                                        color: appColors[value.mode][1],
                                        height: screenHeight / 2.3,
                                        width: screenWidth / 2,
                                        child: Column(children: [
                                          Container(
                                            margin: const EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text("Language",
                                                style: TextStyle(
                                                    color: appColors[value.mode][2],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenWidth / 20)),
                                          ),
                                          for (var i = 0; i < value.languages.length; i++)
                                            ListTile(
                                                title: Text(value.languages[i],
                                                    style: TextStyle(color: appColors[value.mode][2])),
                                                leading: Radio(
                                                    value: i,
                                                    groupValue: value.language,
                                                    activeColor: Colors.blue,
                                                    onChanged: ((newValue) {
                                                      setState(() {
                                                        value.language = i;
                                                      });
                                                    }))),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(20),
                                              alignment: Alignment.centerRight,
                                              child: Text("SELECT",
                                                  style: TextStyle(
                                                      color: Colors.blue, fontSize: screenWidth / 20)),
                                            ),
                                          ),
                                        ])),
                                  ),
                                ));
                      },
                      child: Row(children: [
                        Icon(Icons.language, color: appColors[value.mode][2], size: screenWidth / 15),
                        SizedBox(width: screenWidth / 20),
                        Text("Language",
                            style:
                                TextStyle(color: appColors[value.mode][2], fontSize: screenWidth / 22)),
                        SizedBox(height: screenHeight / 10)
                      ])),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenWidth / 20),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => Dialog(
                                    child: Container(
                                        color: appColors[value.mode][1],
                                        height: screenHeight / 2.5,
                                        width: screenWidth / 2,
                                        child: Column(children: [
                                          Container(
                                            margin: const EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text("Appearance",
                                                style: TextStyle(
                                                    color: appColors[value.mode][2],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenWidth / 20)),
                                          ),
                                          for (var i = 0; i < value.modes.length; i++)
                                            ListTile(
                                                title: Text(value.modes[i],
                                                    style: TextStyle(color: appColors[value.mode][2])),
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
                                              child: Text("SELECT",
                                                  style: TextStyle(
                                                      color: Colors.blue, fontSize: screenWidth / 20)),
                                            ),
                                          ),
                                        ])),
                                  ),
                                ));
                      },
                      child: Row(children: [
                        Icon(Icons.palette, color: appColors[value.mode][2], size: screenWidth / 15),
                        SizedBox(width: screenWidth / 20),
                        Text("Apperance",
                            style:
                                TextStyle(color: appColors[value.mode][2], fontSize: screenWidth / 22)),
                        SizedBox(height: screenHeight / 10)
                      ])),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Consumer<InterfaceController>(
        builder: (context, value, child) => Container(
            color: appColors[value.mode][1],
            height: screenHeight / 10,
            child: Center(
              child: Text("Version 1.0.0",
                  style: TextStyle(fontSize: screenWidth / 20, color: appColors[value.mode][2])),
            )),
      ),
    );
  }
}
