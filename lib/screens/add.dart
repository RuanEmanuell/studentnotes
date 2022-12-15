import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../controller/controller.dart";
import "home.dart";

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
              builder: ((context, value, child) => Column(
                    children: [
                      SafeArea(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Note Title",
                              labelStyle: TextStyle(color: Colors.brown),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: InputBorder.none),
                          style: const TextStyle(fontSize: 25),
                          onChanged: (newValue) {
                            value.noteName = newValue;
                          },
                        ),
                      ),
                      for (var i = 0; i < value.noteBody.length; i++)
                        Row(children: [
                          Container(
                            width: screenWidth / 1.2,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: TextEditingController(text: value.noteBody[i]),
                              decoration: const InputDecoration(
                                  labelText: "Your note here...",
                                  labelStyle: TextStyle(color: Colors.brown),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  border: InputBorder.none),
                              onChanged: (newValue) {
                                value.noteBody[i] = newValue;
                              },
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                value.removeSingleNoteAction(i);
                              }),
                        ])
                    ],
                  ))),
        ),
        bottomNavigationBar: Container(
          color: Colors.yellow[200],
          child: Row(
            children: [
              Container(
                  height: screenHeight / 12,
                  width: screenWidth / 1.4,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.abc, size: 30),
                            onPressed: () {
                              controller.newNoteAction();
                            }),
                      ),
                      Expanded(
                        child: IconButton(icon: const Icon(Icons.check_box, size: 30), onPressed: () {}),
                      ),
                      Expanded(
                        child: IconButton(icon: const Icon(Icons.draw, size: 30), onPressed: () {}),
                      ),
                      Expanded(
                        child:
                            IconButton(icon: const Icon(Icons.add_a_photo, size: 30), onPressed: () {}),
                      ),
                      Expanded(
                        child: IconButton(icon: const Icon(Icons.mic, size: 30), onPressed: () {}),
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 238, 88),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                    icon: const Icon(Icons.check, size: 30),
                    onPressed: () {
                      controller.noteDate =
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                      controller.createAction();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }),
              ),
            ],
          ),
        ));
  }
}
