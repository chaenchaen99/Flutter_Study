

import 'package:flutter/widgets.dart';

String formatElapsedTime(int milliseconds){
  final hours = ((milliseconds / (1000 * 60 * 60)) % 24).floor();
  final minutes = ((milliseconds / (1000 * 60)) % 60).floor();
  final seconds = ((milliseconds / 1000) % 60).floor();
  final milliSecondsDisplay = (milliseconds % 1000).floor();

  return '${hours.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}:${milliSecondsDisplay.toString().padLeft(3,'0')}';
}