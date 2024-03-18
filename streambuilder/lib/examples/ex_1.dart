
import 'package:flutter/material.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('실시간 시계'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Stream.periodic(
              const Duration(seconds: 1), (computationCount) => DateTime.now(), // 매 초마다 stream을 가져올 수 있도록 설정.
            ),
            builder: (context,snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                DateTime? currentTime = snapshot.data;
                return Text('${currentTime?.hour}:${currentTime?.minute}:${currentTime?.second}',
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),);
              }
              return const CircularProgressIndicator();
            } ,
          ),
        ),
      );
}
