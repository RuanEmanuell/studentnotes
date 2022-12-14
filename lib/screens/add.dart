import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../controller/controller.dart";
import "home.dart";

class AddScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var controller = Provider.of<Controller>(context, listen: false);

    controller.titleController = titleController;
    controller.noteController = noteController;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 238, 88),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
              builder: ((context, value, child) => Column(
                    children: [
                      SafeArea(
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                              labelText: "Note Title",
                              labelStyle: TextStyle(color: Colors.brown),
                              border: InputBorder.none),
                          style: const TextStyle(fontSize: 25),
                          onChanged: (newValue) {
                            value.noteName = titleController.text;
                          },
                        ),
                      ),
                      for (var i = 0; i < controller.textNote; i++)
                        TextField(
                          controller: noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              labelText: "Your note here...",
                              labelStyle: TextStyle(color: Colors.brown),
                              border: InputBorder.none),
                        )
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
                      controller.noteBody.add(noteController.text);
                      controller.createAction();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                      controller.resetAction();
                    }),
              ),
            ],
          ),
        ));
  }
}
