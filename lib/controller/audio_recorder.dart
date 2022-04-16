import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? audioRecorder;

  bool isRecorderInitialized = false;

  bool get isRecording => audioRecorder!.isRecording;

  Future init() async {
    audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission");
    }

    await audioRecorder!.openAudioSession();
    isRecorderInitialized = true;
  }

  dispose() {
    if (!isRecorderInitialized) return;

    audioRecorder!.closeAudioSession();
    audioRecorder = null;
    isRecorderInitialized = false;
  }

  Future record() async {
    if (!isRecorderInitialized) return;

    await audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future stop() async {
    if (!isRecorderInitialized) return;

    await audioRecorder!.stopRecorder();
  }

  toggleRecording() async {
    if (audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}


// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// const pathtosave = 'audio_example.aac';

// class SoundRecorder {
//   FlutterSoundRecorder? _audiorecorder;
//   bool isRecorderInitialized = false;
//   bool get isRecording => _audiorecorder!.isStopped;

//   Future init() async {
//     _audiorecorder = FlutterSoundRecorder();
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException("Microphone Permission Required");
//     }
//     await _audiorecorder!.openAudioSession();
//     isRecorderInitialized = true;
//   }

//   void dispose() {
//     if (!isRecorderInitialized) return;
//     _audiorecorder!.closeAudioSession();
//     _audiorecorder = null;
//     isRecorderInitialized = false;
//   }

//   Future _record() async {
//     if (!isRecorderInitialized) return;

//     await _audiorecorder!.startRecorder(toFile: pathtosave);
//   }

//   Future _stop() async {
//     if (!isRecorderInitialized) return;

//     await _audiorecorder!.stopRecorder();
//   }

//   togglerecording() async {
//     if (_audiorecorder!.isStopped) {
//       await _record();
//     } else {
//       await _stop();
//     }
//   }
// }
