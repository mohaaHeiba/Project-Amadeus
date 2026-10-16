import 'package:flutter/foundation.dart';

abstract class TtsService {
  VoidCallback? onStart;
  VoidCallback? onCompletion;
  VoidCallback? onCancel;

  Future<void> init();

  Future<void> speak(String text, {double rate = 0.5});

  Future<void> stop();

  bool get isSpeaking;
}
