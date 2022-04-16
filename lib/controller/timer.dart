// ignore_for_file: prefer_const_constructors, prefer_const_declarations, unused_element

import 'dart:async';

import 'package:flutter/material.dart';

class TimerController extends ValueNotifier<bool> {
  TimerController({bool isPlaying = false}) : super(isPlaying);

  startTimer() {
    value = true;
  }

  stopTimer() {
    value = false;
  }
}

class TimerWidget extends StatefulWidget {
  final TimerController controller;
  const TimerWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = Duration();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  reset() {
    setState(() {
      duration = Duration();
    });
  }

  addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  startTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (e) {
      addTime();
    });
  }

  stopTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildTimer();
  }

  buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(24));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: minutes, header: "Minutes"),
        SizedBox(
          width: 8,
        ),
        buildTimeCard(time: seconds, header: "Seconds"),
        SizedBox(
          width: 8,
        ),
        buildTimeCard(time: hours, header: "Hours"),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Text(
              time,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        Text(
          header,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
