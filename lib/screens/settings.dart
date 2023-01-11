import "package:flutter/material.dart";

import '../widgets/general/appbar.dart';
import '../widgets/settingsscreen/option.dart';
import '../widgets/settingsscreen/settingsbox.dart';

class SettingsScreen extends StatelessWidget {
  var languages = ["Portuguese", "English"];
  var language = 0;

  var modes = ["Light Mode", "Dark Mode"];
  var mode = 0;

  var notifications = ["On", "Off"];
  var notification = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: SettingsAppBar()),
      body: Column(children: [
        SettingsOption(
            dialog: SettingsBox(settings: languages, selectedOption: language),
            icon: Icons.language,
            text: "Language"),
        SettingsOption(
            dialog: SettingsBox(settings: modes, selectedOption: mode),
            icon: Icons.palette,
            text: "Appearance"),
        SettingsOption(
            dialog: SettingsBox(settings: notifications, selectedOption: notification),
            icon: Icons.notifications,
            text: "Notifications"),
        SettingsOptionVip(onTap: () {}, icon: Icons.remove_circle, text: "Remove Ads"),
      ]),
      bottomNavigationBar: Container(
          height: screenHeight / 15,
          margin: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text("Version 1.0.0",
                style:
                    TextStyle(fontSize: screenWidth / 22, color: const Color.fromARGB(255, 88, 88, 88))),
          )),
    );
  }
}
