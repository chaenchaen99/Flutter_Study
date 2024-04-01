import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc_stopwatch_example/utils.dart';

void main() {
  runApp(StopWatchScreen());
}

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

  final List<String> _laps = [];

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer timer) {
        _streamController
            .add(_stopwatch.elapsedMilliseconds); //스트림에 이벤트를 발생시켰음.
      });
    }
  }

  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
    setState(() {
      _laps.clear();
    });
  }

  void _recordLap() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final lapTime = formatElapsedTime(milliseconds);
    setState(() {
      _laps.add(lapTime);
    });
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
  Widget build(BuildContext context) => MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: const Text('스톱워치'),
        ),
        body: Column(children: [
          Center(
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                final milliseconds = snapshot.data ?? 0;
                return Text(
                  formatElapsedTime(milliseconds),
                  style: const TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _laps.length,
                itemBuilder: ((context, index) => ListTile(
                      title: Text('Lab ${index + 1}: ${_laps[index]}'),
                    )
                )
            ),
          ),
        ]),
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
            ),
            FloatingActionButton(
              onPressed: _recordLap,
              tooltip: '랩 기록',
              child: const Icon(Icons.flag),
            ),
          ],
        ),
      ),
  );
}
