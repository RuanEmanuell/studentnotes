import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../controller/interfacecontroller.dart';
import '../models/appcolors.dart';
import '../widgets/general/appbar.dart';
import '../widgets/settingsscreen/option.dart';
import '../widgets/settingsscreen/settingsbox.dart';

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
          child: Column(children: [
            SettingsOption(
                dialog: SettingsBox(settings: value.languages, selectedOption: value.language),
                icon: Icons.language,
                text: "Language"),
            SettingsOption(
                dialog: SettingsBox(settings: value.modes, selectedOption: value.mode),
                icon: Icons.palette,
                text: "Appearance"),
            SettingsOption(
                dialog: SettingsBox(settings: value.notifications, selectedOption: value.notification),
                icon: Icons.notifications,
                text: "Notifications"),
            SettingsOptionVip(onTap: () {}, icon: Icons.remove_circle, text: "Remove Ads"),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
          height: screenHeight / 15,
          margin: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text("Version 1.0.0",
                style: TextStyle(fontSize: screenWidth / 22, color: appColors[0][1])),
          )),
    );
  }
}
