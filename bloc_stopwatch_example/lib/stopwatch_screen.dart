

import 'dart:async';
import 'package:bloc_stopwatch_example/bloc/stopwatch_bloc.dart';
import 'package:bloc_stopwatch_example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  //bloc StopwatchStarted
  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer timer) {
        _streamController
            .add(_stopwatch.elapsedMilliseconds); //스트림에 이벤트를 발생시켰음.
      });
    }
  }

  //bloc StopwatchStopped
  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  //bloc StopwatchReset
  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
    setState(() {
      _laps.clear();
    });
  }

  //bloc StopwatchRecorded
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
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchStarted()),
          tooltip: '시작',
          child: const Icon(Icons.play_arrow),
        ),
        FloatingActionButton(
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchStopped()),
          tooltip: '정지',
          child: const Icon(Icons.stop),
        ),
        FloatingActionButton(
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchReset()),
          tooltip: '재시작',
          child: const Icon(Icons.refresh),
        ),
        FloatingActionButton(
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchRecorded()),
          tooltip: '랩 기록',
          child: const Icon(Icons.flag),
        ),
      ],
    ),
  ),
  );
}
