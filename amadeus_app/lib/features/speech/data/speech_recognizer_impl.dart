import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../domain/speech_recognizer.dart';

class SpeechRecognizerImpl implements SpeechRecognizer {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isKeepListeningActive = false;

  Function(String)? _currentOnResult;
  Function(String)? _currentOnFinalResult;

  @override
  Future<bool> init() async {
    if (!_isInitialized) {
      if (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
        _isInitialized = await _speechToText.initialize(
          onStatus: (status) {
            if ((status == 'notListening' || status == 'done') &&
                _isKeepListeningActive) {
              _restartListening();
            }
          },
          onError: (error) {
            if (_isKeepListeningActive) {
              _restartListening();
            }
          },
        );
      } else {
        _isInitialized = false;
      }
    }
    return _isInitialized;
  }

  @override
  void start({
    required Function(String text) onResult,
    required Function(String finalWord) onFinalResult,
  }) async {
    _isKeepListeningActive = true;
    _currentOnResult = onResult;
    _currentOnFinalResult = onFinalResult;

    await init();
    _triggerListen();
  }

  Future<void> _triggerListen() async {
    if (!_isKeepListeningActive ||
        _speechToText.isListening ||
        !_isInitialized) {
      return;
    }

    try {
      await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) {
          if (_currentOnResult != null) {
            _currentOnResult!(result.recognizedWords);
          }

          if (result.finalResult && result.recognizedWords.isNotEmpty) {
            if (_currentOnFinalResult != null) {
              _currentOnFinalResult!(result.recognizedWords);
            }
          }
        },
        localeId: 'en-US',
        listenOptions: SpeechListenOptions(
          partialResults: true,
          listenMode: ListenMode.dictation,
          cancelOnError: true,
        ),
      );
    } catch (_) {}
  }

  void _restartListening() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_isKeepListeningActive && !_speechToText.isListening) {
        _triggerListen();
      }
    });
  }

  @override
  void stop() {
    _isKeepListeningActive = false;
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
  }

  @override
  bool get isListening => _speechToText.isListening;
}
