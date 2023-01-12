import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/notecontroller.dart';
import '../models/appcolors.dart';
import '../widgets/general/appbar.dart';
import '../widgets/general/delete.dart';
import '../widgets/general/bigbutton.dart';
import '../widgets/homescreen/ballontext.dart';
import 'note.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var noteController = Provider.of<NoteController>(context, listen: false);
    return Scaffold(
        backgroundColor: appColors[0][1],
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: HomeAppBar()),
        body: Consumer<NoteController>(
          builder: (context, value, child) => value.notes.isEmpty
              ? Center(
                  child: Text("Your notes will be here...", style: TextStyle(color: appColors[0][2])))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: noteController.notes.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  BallonText(text: value.notes[index][2], fontSize: 15.0),
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
                                            color: value.notes[index][1][0][0],
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
                                            BallonText(text: value.notes[index][0], fontSize: 25.0),
                                            const SizedBox(height: 10),
                                            BallonText(fontSize: 15.0, text: value.notes[index][1][1][1])
                                          ]),
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  DeleteButton(onPressed: () {
                                    value.removeAction(index);
                                  })
                                ]),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: BigIconButton(
            color: appColors[0][2],
            iconColor: appColors[0][0],
            icon: Icons.add,
            onPressed: () {
              noteController.resetAction();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(),
                  ));
            }));
  }
}
