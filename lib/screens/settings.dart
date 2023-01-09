import "package:flutter/material.dart";

import '../widgets/general/appbar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: SettingsAppBar()),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(left: screenWidth / 20),
          child: InkWell(
              onTap: () {},
              child: Row(children: [
                Icon(Icons.language, color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
                SizedBox(width: screenWidth / 20),
                Text("Language", style: TextStyle(fontSize: screenWidth / 22)),
                SizedBox(height: screenHeight / 10)
              ])),
        ),
        Container(
          margin: EdgeInsets.only(left: screenWidth / 20),
          child: InkWell(
              onTap: () {},
              child: Row(children: [
                Icon(Icons.palette, color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
                SizedBox(width: screenWidth / 20),
                Text("Appearance", style: TextStyle(fontSize: screenWidth / 22)),
                SizedBox(height: screenHeight / 10)
              ])),
        ),
        Container(
          margin: EdgeInsets.only(left: screenWidth / 20),
          child: InkWell(
              onTap: () {},
              child: Row(children: [
                Icon(Icons.notifications,
                    color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
                SizedBox(width: screenWidth / 20),
                Text("Notifications", style: TextStyle(fontSize: screenWidth / 22)),
                SizedBox(height: screenHeight / 10)
              ])),
        ),
        Container(
            margin: EdgeInsets.only(left: screenWidth / 20),
            child: InkWell(
                onTap: () {},
                child: Row(children: [
                  Icon(Icons.remove_circle,
                      color: const Color.fromARGB(255, 88, 88, 88), size: screenWidth / 15),
                  SizedBox(width: screenWidth / 20),
                  Text("Remove Ads", style: TextStyle(fontSize: screenWidth / 22)),
                  SizedBox(width: screenWidth / 40),
                  Container(
                      width: screenWidth / 10,
                      margin: EdgeInsets.all(screenHeight / 100),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 216, 41),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text("VIP",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      )),
                  SizedBox(height: screenHeight / 10)
                ]))),
      ]),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text("Version 1.0.0",
                  style: TextStyle(fontSize: screenWidth / 22, color: const Color.fromARGB(255, 88, 88, 88)))),
        ],
      ),
    );
  }
}
