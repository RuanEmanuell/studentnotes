import "package:flutter/material.dart";

class SettingsBox extends StatelessWidget {
  var settings;
  var selectedOption;

  SettingsBox({required this.settings, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      child: SizedBox(
          height: screenHeight / 2.75,
          width: screenWidth / 2,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text("Language",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth / 20)),
            ),
            for (var i = 0; i < settings.length; i++)
              ListTile(
                  title: Text(settings[i]),
                  leading: Radio(
                      value: i,
                      groupValue: settings,
                      activeColor: Colors.blue,
                      onChanged: ((value) {
                        selectedOption = i;
                        print(selectedOption);
                      }))),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text("SELECT", style: TextStyle(color: Colors.blue, fontSize: screenWidth / 20)),
              ),
            ),
          ])),
    );
  }
}
