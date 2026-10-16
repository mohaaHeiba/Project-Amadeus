import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../domain/tts_service.dart';

class TtsServiceImpl implements TtsService {
  final FlutterTts _flutterTts;
  bool _isInitialized = false;
  bool _isSpeaking = false;

  @override
  VoidCallback? onStart;

  @override
  VoidCallback? onCompletion;

  @override
  VoidCallback? onCancel;

  TtsServiceImpl({FlutterTts? flutterTts})
      : _flutterTts = flutterTts ?? FlutterTts() {
    _initHandlers();
  }

  void _initHandlers() {
    _flutterTts.setStartHandler(() {
      _isSpeaking = true;
      onStart?.call();
    });

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      onCompletion?.call();
    });

    _flutterTts.setCancelHandler(() {
      _isSpeaking = false;
      onCancel?.call();
    });

    _flutterTts.setErrorHandler((dynamic message) {
      debugPrint('TTS Error: $message');
      _isSpeaking = false;
      onCancel?.call();
    });
  }

  @override
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      if (!kIsWeb && Platform.isAndroid) {
        try {
          await _flutterTts.setEngine('com.google.android.tts');
        } catch (e) {
          debugPrint('TTS: Could not set Google TTS engine: $e');
        }
      }

      await _flutterTts.setLanguage('en-US');
      // Slightly higher pitch for young female character (Kurisu Makise)
      await _flutterTts.setPitch(1.15);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);

      if (!kIsWeb && Platform.isIOS) {
        await _flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          ],
          IosTextToSpeechAudioMode.defaultMode,
        );
      }

      await _selectHumanVoice();

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize TTS: $e');
    }
  }

  /// Selects the most natural, human-sounding English female voice available on the device.
  Future<void> _selectHumanVoice() async {
    try {
      final dynamic rawVoices = await _flutterTts.getVoices;
      if (rawVoices is! List || rawVoices.isEmpty) return;

      Map<String, String>? selectedVoice;

      if (!kIsWeb && Platform.isAndroid) {
        // Android: Search for Google's WaveNet network voices (sound extremely human, avoid "local")
        for (final item in rawVoices) {
          if (item is! Map) continue;
          final name = item['name']?.toString() ?? '';
          final locale = item['locale']?.toString() ?? '';
          final lowerName = name.toLowerCase();
          final lowerLocale = locale.toLowerCase().replaceAll('_', '-');

          if (!lowerLocale.startsWith('en-us') && !lowerLocale.startsWith('en-gb')) continue;
          if (lowerName.contains('local') || lowerName.contains('embedded')) continue;
          if (lowerName.contains('male') || lowerName.contains('david') || lowerName.contains('guy')) continue;

          // Priority 1: Google WaveNet female network voice (e.g. en-us-x-sfg-network)
          if (lowerName.contains('network') &&
              (lowerName.contains('sfg') ||
                  lowerName.contains('tpd') ||
                  lowerName.contains('iol') ||
                  lowerName.contains('female'))) {
            selectedVoice = {'name': name, 'locale': locale};
            break;
          }

          // Priority 2: Any English network voice
          if (selectedVoice == null && lowerName.contains('network')) {
            selectedVoice = {'name': name, 'locale': locale};
          }
        }
      } else if (!kIsWeb && Platform.isIOS) {
        // iOS: Search for voices containing "premium", "enhanced", or "siri". Fallback to "Samantha".
        Map<String, String>? samanthaFallback;

        for (final item in rawVoices) {
          if (item is! Map) continue;
          final name = item['name']?.toString() ?? '';
          final locale = item['locale']?.toString() ?? '';
          final lowerName = name.toLowerCase();
          final lowerLocale = locale.toLowerCase().replaceAll('_', '-');

          if (!lowerLocale.startsWith('en')) continue;
          if (lowerName.contains('male') || lowerName.contains('alex') || lowerName.contains('daniel')) continue;

          if (lowerName.contains('samantha')) {
            samanthaFallback = {'name': name, 'locale': locale};
          }

          if (lowerName.contains('premium') || lowerName.contains('enhanced') || lowerName.contains('siri')) {
            selectedVoice = {'name': name, 'locale': locale};
            break;
          }
        }

        selectedVoice ??= samanthaFallback;
      }

      // General fallback if platform specific search didn't match
      if (selectedVoice == null) {
        for (final item in rawVoices) {
          if (item is! Map) continue;
          final name = item['name']?.toString() ?? '';
          final locale = item['locale']?.toString() ?? '';
          final lowerName = name.toLowerCase();
          final lowerLocale = locale.toLowerCase().replaceAll('_', '-');

          if (lowerLocale.startsWith('en') &&
              (lowerName.contains('female') ||
                  lowerName.contains('samantha') ||
                  lowerName.contains('karen') ||
                  lowerName.contains('victoria') ||
                  lowerName.contains('zira'))) {
            selectedVoice = {'name': name, 'locale': locale};
            break;
          }
        }
      }

      if (selectedVoice != null) {
        await _flutterTts.setVoice({
          'name': selectedVoice['name']!,
          'locale': selectedVoice['locale']!,
        });
        debugPrint('TTS: Selected voice: ${selectedVoice['name']} (${selectedVoice['locale']})');
      }
    } catch (e) {
      debugPrint('TTS: Voice selection error: $e');
    }
  }

  @override
  Future<void> speak(String text, {double rate = 0.5}) async {
    if (text.trim().isEmpty) {
      onCompletion?.call();
      return;
    }

    if (!_isInitialized) {
      await init();
    }

    try {
      await _flutterTts.setSpeechRate(rate.clamp(0.1, 1.0));
      _isSpeaking = true;
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS speak error: $e');
      _isSpeaking = false;
      onCancel?.call();
      onCompletion?.call();
    }
  }

  @override
  Future<void> stop() async {
    try {
      _isSpeaking = false;
      await _flutterTts.stop();
      onCancel?.call();
    } catch (e) {
      debugPrint('TTS stop error: $e');
    }
  }

  @override
  bool get isSpeaking => _isSpeaking;
}
