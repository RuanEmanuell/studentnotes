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
      body: Consumer<Controller>(
        builder: (context, value, child) => value.notes[0].isEmpty
            ? const Center(child: Text("Your notes will be displayed here..."))
            : Column(
                children: [
                  SizedBox(
                    height: screenHeight,
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: Provider.of<Controller>(context, listen: false).notes[0].length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(value.notes[2][index]),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => NoteScreen(index: index)));
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
                                        Text(value.notes[0][index],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 25)),
                                        const SizedBox(height: 10),
                                        Text(
                                          value.notes[1][index][0],
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
