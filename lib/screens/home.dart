import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";
import 'add.dart';
import 'note.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 238, 88),
      body: SingleChildScrollView(
        child: Consumer<Controller>(
          builder: (context, value, child) => value.notes.isEmpty
              ? const Center(child: Text("Your notes will be displayed here..."))
              : Column(
                  children: [
                    SizedBox(
                      height: screenHeight,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: Provider.of<Controller>(context, listen: false).notes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(value.notes[index][2]),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    value.loadNoteAction(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NoteScreen(index: index)));
                                  },
                                  child: Container(
                                      width: screenWidth / 2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(123, 117, 117, 117),
                                                spreadRadius: 1,
                                                blurRadius: 10)
                                          ]),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(children: [
                                          Text(value.notes[index][0],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 25)),
                                          const SizedBox(height: 10),
                                          Text(
                                            value.notes[index][1][0],
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ]),
                                      )),
                                ),
                                const SizedBox(height: 10),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      value.removeAction(index);
                                    }),
                              ]),
                            );
                          }),
                    ),
                  ],
                ),
        ),
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
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScreen(),
                    ));
              })),
    );
  }
}
