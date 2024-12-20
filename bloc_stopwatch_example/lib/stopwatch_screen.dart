import 'package:bloc_stopwatch_example/bloc/stopwatch_bloc.dart';
import 'package:bloc_stopwatch_example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('스톱워치'),
    ),
    body: Column(children: [
      Center(
        child: BlocBuilder<StopwatchBloc, StopwatchState>(
          builder: (context, state) => Text(
            formatElapsedTime(state.elapsedTime),
            style: const TextStyle(
                fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Expanded(
        child: BlocBuilder<StopwatchBloc, StopwatchState>(
          builder: (context, state) => ListView.builder(
              itemCount: state.laps.length,
              itemBuilder: ((context, index) => ListTile(
                title: Text('Lab ${index + 1}: ${state.laps[index]}'),
              ))),
        ),
      ),
    ]),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: () =>
              context.read<StopwatchBloc>().add(const StopwatchStarted()),
          tooltip: '시작',
          child: const Icon(Icons.play_arrow),
        ),
        FloatingActionButton(
          onPressed: () =>
              context.read<StopwatchBloc>().add(const StopwatchStopped()),
          tooltip: '정지',
          child: const Icon(Icons.stop),
        ),
        FloatingActionButton(
          onPressed: () =>
              context.read<StopwatchBloc>().add(const StopwatchReset()),
          tooltip: '재시작',
          child: const Icon(Icons.refresh),
        ),
        FloatingActionButton(
          onPressed: () => context
              .read<StopwatchBloc>()
              .add(const StopwatchRecorded()),
          tooltip: '랩 기록',
          child: const Icon(Icons.flag),
        ),
      ],
    ),
  );
}
