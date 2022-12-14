import "package:flutter/material.dart";

class SettingsOption extends StatelessWidget {
  var dialog;
  var icon;
  var text;

  SettingsOption({required this.dialog, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: screenWidth / 20),
      child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => dialog,
            );
          },
          child: Row(children: [
            Icon(icon, color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
            SizedBox(width: screenWidth / 20),
            Text(text, style: TextStyle(fontSize: screenWidth / 22)),
            SizedBox(height: screenHeight / 10)
          ])),
    );
  }
}

class SettingsOptionVip extends StatelessWidget {
  var onTap;
  var icon;
  var text;

  SettingsOptionVip({required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(left: screenWidth / 20),
        child: InkWell(
            onTap: () {},
            child: Row(children: [
              Icon(icon, color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
              SizedBox(width: screenWidth / 20),
              Text(text, style: TextStyle(fontSize: screenWidth / 22)),
              SizedBox(width: screenWidth / 40),
              Container(
                  width: screenWidth / 10,
                  margin: EdgeInsets.all(screenHeight / 100),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 216, 41),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child:
                        Text("VIP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  )),
              SizedBox(height: screenHeight / 10)
            ])));
  }
}
