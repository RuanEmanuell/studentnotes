import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../controller/controller.dart";
import "home.dart";

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 238, 88),
      body: Column(
        children: [
          SafeArea(
            child: TextField(
              decoration: const InputDecoration(
                  labelText: "Note Title",
                  labelStyle: TextStyle(color: Colors.brown),
                  border: InputBorder.none),
              style: const TextStyle(fontSize: 25),
              onChanged: (value) {
                controller.noteName = value;
              },
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                labelText: "Your note here...",
                labelStyle: TextStyle(color: Colors.brown),
                border: InputBorder.none),
            onChanged: (value) {
              controller.noteBody = value;
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.yellow[200],
            border: Border.all(
              color: Colors.black,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: IconButton(
            icon: const Icon(Icons.check, size: 30),
            onPressed: () {
              controller.createAction();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            }),
      ),
    );
  }
}
