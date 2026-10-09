import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ContinuousSttService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isKeepListeningActive = false;

  Future<void> init() async {
    if (!_isInitialized) {
      _isInitialized = await _speechToText.initialize(
        onStatus: (status) {
          print('STT Status: $status');
          if ((status == 'notListening' || status == 'done') &&
              _isKeepListeningActive) {
            _restartListening();
          }
        },
        onError: (error) {
          print('STT Error: $error');
          if (_isKeepListeningActive) {
            _restartListening();
          }
        },
      );
    }
  }

  void start({
    required Function(String text) onResult,
    required Function(String finalWord) onFinalResult,
  }) async {
    _isKeepListeningActive = true;
    await init();
    _triggerListen(onResult: onResult, onFinalResult: onFinalResult);
  }

  void _triggerListen({
    required Function(String text) onResult,
    required Function(String finalWord) onFinalResult,
  }) async {
    if (!_isKeepListeningActive || _speechToText.isListening) return;

    try {
      await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) {
          onResult(result.recognizedWords);

          if (result.finalResult && result.recognizedWords.isNotEmpty) {
            onFinalResult(result.recognizedWords);
          }
        },
        localeId: 'ar-EG', // ar-EG / en-US
        pauseFor: const Duration(seconds: 3),
      );
    } catch (e) {
      print('Listen exception: $e');
    }
  }

  void _restartListening() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_isKeepListeningActive && !_speechToText.isListening) {}
    });
  }

  void stop() {
    _isKeepListeningActive = false;
    _speechToText.stop();
  }
}
