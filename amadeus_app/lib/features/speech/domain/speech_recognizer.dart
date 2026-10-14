abstract class SpeechRecognizer {
  Future<bool> init();

  void start({
    required Function(String text) onResult,
    required Function(String finalWord) onFinalResult,
  });

  void stop();

  bool get isListening;
}
