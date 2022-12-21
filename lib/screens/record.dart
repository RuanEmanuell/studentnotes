import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/audiocontroller.dart';
import '../controller/controller.dart';

class SimpleRecorder extends StatefulWidget {
  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder> {
  void initState() {
    super.initState();
    Provider.of<AudioController>(context, listen: false).mPlayer!.openPlayer().then((thenValue) {
      Provider.of<AudioController>(context, listen: false).mPlayerIsInited = true;
    });

    Provider.of<AudioController>(context, listen: false).openTheRecorder().then((thenValue) {
      Provider.of<AudioController>(context, listen: false).mRecorderIsInited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Consumer<AudioController>(
        builder: (context, value, child) => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {
                    value.changeRecording();
                    if (!value.recording) {
                      value.record();
                    } else {
                      value.stopRecorder();
                      Navigator.pop(context);
                      Provider.of<Controller>(context, listen: false).newAudioAction(value.mPath);
                    }
                  },
                  child: Text(value.mRecorder!.isRecording ? 'Stop' : 'Record'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(value.mRecorder!.isRecording ? 'Recording in progress' : 'Recorder is stopped'),
              ]),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Simple Recorder'),
      ),
      body: makeBody(),
    );
  }
}
