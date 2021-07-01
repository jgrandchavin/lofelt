import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lofelt/lofelt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioCache cache = AudioCache();

  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    try {
      await Lofelt.init();
      await Lofelt.load('assets/haptics/lfa.haptic');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> play() async {
    audioPlayer =
        await cache.play('audio/lfa.mp3', mode: PlayerMode.LOW_LATENCY);
    await Future.delayed(Duration(milliseconds: 200));
    Lofelt.play();
  }

  Future<void> stop() async {
    audioPlayer?.stop();
    Lofelt.stop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: const Text('Lofelt Example'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: play,
                  child: Icon(Icons.play_arrow),
                ),
                ElevatedButton(
                  onPressed: stop,
                  child: Icon(Icons.stop),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Test with Lexus LFA sound',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
