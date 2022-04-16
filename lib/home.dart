// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/controller/audio_recorder.dart';
import 'package:flutter_audio_recorder/controller/timer.dart';

class AudioRecorder extends StatefulWidget {
  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final recorder = SoundRecorder();
  final timerController = TimerController();

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Audio Recorder"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              buildStartBtn(),
              SizedBox(
                height: 10,
              ),
              buildPlayBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStartBtn() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? "Start" : "Start";
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(160, 50), primary: primary, onPrimary: onPrimary),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () async {
        await recorder.toggleRecording();
        final isRecording = recorder.isRecording;
        setState(() {});

        if (isRecording) {
          timerController.startTimer();
        } else {
          timerController.stopTimer();
        }
      },
    );
  }

  Widget buildPlayBtn() {
    final isPlaying = false;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? "Stop Playing" : "Play Recording";
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(160, 50), primary: primary, onPrimary: onPrimary),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () async {},
    );
  }

  Widget buildTimer() {
    return Column(
      children: [
        Icon(
          Icons.mic,
          size: 30,
        ),
        TimerWidget(controller: timerController),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
