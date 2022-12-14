import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/maincontroller.dart';
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
    var controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 12), child: HomeAppBar()),
        body: Consumer<Controller>(
          builder: (context, value, child) => value.notes.isEmpty
              ? const Center(child: Text("Your notes will be here..."))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: controller.notes.length,
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
            color: Colors.black,
            iconColor: Colors.white,
            icon: Icons.add,
            onPressed: () {
              controller.resetAction();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(),
                  ));
            }));
  }
}
