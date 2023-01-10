import "package:flutter/material.dart";

class SettingsBox extends StatefulWidget {
  @override
  State<SettingsBox> createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  var languages = ["English", "Portuguese"];

  var language = 0;

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
            for (var i = 0; i < languages.length; i++)
              ListTile(
                  title: Text(languages[i]),
                  leading: Radio(
                      value: i,
                      groupValue: language,
                      activeColor: Colors.blue,
                      onChanged: ((value) {
                        setState(() {
                          language = languages.indexOf(languages[i]);
                        });
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
