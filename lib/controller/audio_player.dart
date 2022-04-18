// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

final pathToReadVideo = 'audio_example.aac';

class AudioPlayer {
  FlutterSoundPlayer? audio_player;

  bool get isPlaying => audio_player!.isPlaying;

  Future init() async {
    audio_player = FlutterSoundPlayer();

    await audio_player!.openAudioSession();
  }

  dispose() {
    audio_player!.closeAudioSession();
    audio_player = null;
  }

  Future play(VoidCallback whenFinished) async {
    await audio_player!
        .startPlayer(fromURI: pathToReadVideo, whenFinished: whenFinished);
  }

  Future stop() async {
    await audio_player!.stopPlayer();
  }

  Future toggle_playing({required VoidCallback whenFinished}) async {
    if (audio_player!.isStopped) {
      await play(whenFinished);
    } else {
      await stop();
    }
  }
}
