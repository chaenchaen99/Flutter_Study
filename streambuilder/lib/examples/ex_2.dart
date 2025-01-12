import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _tick = const Duration(milliseconds: 10); // 10 밀리초 간격

  late Timer _timer;
  late StreamController<int> _streamController;

  void _startTimer() {
    if(!_stopwatch.isRunning){
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer timer) {
        _streamController.add(_stopwatch.elapsedMilliseconds); //스트림에 이벤트를 발생시켰음.
      });
    }
  }
  void _stopTimer() {
    if(_stopwatch.isRunning)
      {
        _stopwatch.stop();
        _timer.cancel();
      }
  }
  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>();
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('스톱워치'),
        ),
        body: Center(
            child: StreamBuilder<int>(
                stream: _streamController.stream,
                builder:(context, snapshot) {
                  final milliseconds = snapshot.data ?? 0;
                  final hours = ((milliseconds / (1000 * 60 * 60)) % 24).floor();
                  final minutes = ((milliseconds / (1000 * 60)) % 60).floor();
                  final seconds = ((milliseconds / 1000) % 60).floor();
                  final milliSecondsDisplay = (milliseconds % 1000).floor();
                  return Text(
                  '${hours.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}:${milliSecondsDisplay.toString().padLeft(3,'0')}',
                  style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                  );
                },
            ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: _startTimer,
              tooltip: '시작',
              child: const Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: _stopTimer,
              tooltip: '정지',
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              onPressed: _resetTimer,
              tooltip: '재시작',
              child: const Icon(Icons.refresh),
            )
          ],
        ),
      );
}
