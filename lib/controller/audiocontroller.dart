import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioController extends ChangeNotifier {
  int audio = 0;
  Codec codec = Codec.aacMP4;
  String mPath = "audio0.mp4";
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  bool mPlayerIsInited = false;
  bool mRecorderIsInited = false;
  bool mplaybackReady = false;

  bool recording = false;
  bool paused = false;
  bool isPlaying = false;

  var durationSeconds = 0;
  var durationMinutes = 0;
  var audioDuration = "00:00";
  var durationTimer;
  var rawDuration = 0;
  var setState;

  var theSource = AudioSource.microphone;

  @override
  void dispose() {
    mPlayer!.closePlayer();
    mPlayer = null;

    mRecorder!.closeRecorder();
    mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    await mRecorder!.openRecorder();
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth | AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    mRecorderIsInited = true;
  }

  void record() {
    audio++;
    mPath = "audio$audio.mp4";
    mRecorder!.startRecorder(
      toFile: mPath,
      codec: codec,
      audioSource: theSource,
    );
    recording = true;
    durationCreator();
    notifyListeners();
  }

  void stopRecorder() async {
    await mRecorder!.stopRecorder().then((value) {
      mplaybackReady = true;
      recording = false;
    });
    durationTimer.cancel();
    notifyListeners();
  }

  play(audio) {
    mPlayer!.startPlayer(
      fromURI: audio,
    );
  }

  void stopPlayer() {
    mPlayer!.stopPlayer();
  }

  void pauseRecorder() {
    mRecorder!.pauseRecorder();
    paused = true;
    notifyListeners();
  }

  void resumeRecorder() {
    mRecorder!.resumeRecorder();
    paused = false;
    notifyListeners();
  }

  void restartDuration() {
    durationSeconds = 0;
    durationMinutes = 0;
    audioDuration = "00:00";
    rawDuration = 0;
    notifyListeners();
  }

  void initPlayerAndRecorder() {
    mPlayer!.openPlayer().then((thenValue) {
      mPlayerIsInited = true;
    });

    openTheRecorder().then((thenValue) {
      mRecorderIsInited = true;
    });
  }

  void durationCreator() {
    durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!paused) {
          rawDuration++;

          if (durationSeconds > 59) {
            durationSeconds = 0;
            durationMinutes++;
          } else {
            durationSeconds++;
          }

          if (durationSeconds < 10 && durationMinutes < 10) {
            audioDuration = "0$durationMinutes:0$durationSeconds";
          } else if (durationSeconds < 10) {
            audioDuration = "$durationMinutes:0$durationSeconds";
          } else if (durationMinutes < 10) {
            audioDuration = "0$durationMinutes:$durationSeconds";
          } else {
            audioDuration = "$durationMinutes:$durationSeconds";
          }
        }
      });
    });
  }
}
