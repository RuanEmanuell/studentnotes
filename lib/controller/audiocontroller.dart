import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AudioController extends ChangeNotifier {
  Codec codec = Codec.aacMP4;
  String mPath = 'tau_file.mp4';
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  bool mPlayerIsInited = false;
  bool mRecorderIsInited = false;
  bool mplaybackReady = false;

  bool recording = false;
  bool paused = false;

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
    mRecorder!.startRecorder(
      toFile: mPath,
      codec: codec,
      audioSource: theSource,
    );
    recording = true;
    notifyListeners();
  }

  void stopRecorder() async {
    await mRecorder!.stopRecorder().then((value) {
      mplaybackReady = true;
      recording = false;
    });
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

  void initPlayerAndRecorder() {
    mPlayer!.openPlayer().then((thenValue) {
      mPlayerIsInited = true;
    });

    openTheRecorder().then((thenValue) {
      mRecorderIsInited = true;
    });
  }
}
