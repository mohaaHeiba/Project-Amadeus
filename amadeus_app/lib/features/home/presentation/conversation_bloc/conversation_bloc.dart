import 'dart:async';
import 'dart:math';

import 'package:amadeus_app/core/constants/avatar_emotion.dart';
import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/features/ai/domain/entities/chat_message.dart';
import 'package:amadeus_app/features/ai/domain/usecases/send_message_usecase.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
import 'package:amadeus_app/features/speech/domain/speech_recognizer.dart';
import 'package:amadeus_app/features/speech/domain/tts_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final SendMessageUsecase sendMessageUsecase;
  final CacheHelper cacheHelper;
  final SpeechRecognizer speechRecognizer;
  final TtsService ttsService;
  final AvatarBloc avatarBloc;

  final List<ChatMessage> _chatHistory = [];
  static const int _maxHistory = 20;

  Timer? _idleTimer;
  static const Duration _idleTimeoutDuration = Duration(seconds: 15);

  Timer? _lipSyncTimer;

  ConversationBloc({
    required this.sendMessageUsecase,
    required this.cacheHelper,
    required this.speechRecognizer,
    required this.ttsService,
    required this.avatarBloc,
  }) : super(ConversationInitial(mode: cacheHelper.getInteractionMode)) {
    _initTtsListeners();

    on<AppReadyEvent>(_onAppReady);

    on<StartListeningEvent>(_onStartListening);
    on<UpdateListeningTextEvent>(_onUpdateListeningText);
    on<StopListeningEvent>(_onStopListening);

    on<SendUserMessageEvent>(_onSendUserMessage, transformer: droppable());
    on<SpeakingFinishedEvent>(_onSpeakingFinished);
    on<ConversationFailedEvent>(_onConversationFailed);
    on<ChangeInteractionModeEvent>(_onChangeMode);

    on<ResetIdleTimerEvent>(_onResetIdleTimer);
    on<IdleTimeoutEvent>(_onIdleTimeout);
  }

  void _initTtsListeners() {
    ttsService.onStart = () {
      _startLipSync();
    };

    ttsService.onCompletion = () {
      _stopLipSync();
      if (!isClosed) {
        add(SpeakingFinishedEvent());
      }
    };

    ttsService.onCancel = () {
      _stopLipSync();
    };
  }

  void _startLipSync() {
    _stopLipSync();
    final random = Random();

    _lipSyncTimer = Timer.periodic(const Duration(milliseconds: 110), (timer) {
      if (!ttsService.isSpeaking) {
        _stopLipSync();
        return;
      }
      // Alternate mouth values between 25.0 and 85.0 to mimic speech syllables,
      // with occasional 0.0 values for natural pauses between words.
      final value = (random.nextInt(10) < 2)
          ? 0.0
          : 25.0 + (random.nextDouble() * 60.0);
      avatarBloc.add(UpdateMouthValueEvent(value));
    });
  }

  void _stopLipSync() {
    _lipSyncTimer?.cancel();
    _lipSyncTimer = null;
    avatarBloc.add(UpdateMouthValueEvent(0.0));
  }

  void _resetIdleTimer() {
    _cancelIdleTimer();

    // Do not start idle timer if actively speaking or thinking
    if (ttsService.isSpeaking ||
        state is ConversationSpeaking ||
        state is ConversationThinking) {
      return;
    }

    _idleTimer = Timer(_idleTimeoutDuration, () {
      if (!isClosed) {
        add(IdleTimeoutEvent());
      }
    });
  }

  void _cancelIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = null;
  }

  void _onResetIdleTimer(
    ResetIdleTimerEvent event,
    Emitter<ConversationState> emit,
  ) {
    if (state is! ConversationThinking &&
        state is! ConversationSpeaking &&
        !ttsService.isSpeaking) {
      _resetIdleTimer();
    }
  }

  void _onAppReady(AppReadyEvent event, Emitter<ConversationState> emit) {
    ttsService.init();

    emit(ConversationIdle(mode: state.mode));
    _resetIdleTimer();

    // Auto-start listening when app is ready in voice mode
    if (state.mode == InteractionMode.voice) {
      add(StartListeningEvent());
    }
  }

  Future<void> _onStartListening(
    StartListeningEvent event,
    Emitter<ConversationState> emit,
  ) async {
    // Interrupt any ongoing speech immediately
    _stopLipSync();
    if (ttsService.isSpeaking) {
      await ttsService.stop();
    }

    emit(ConversationListening(mode: state.mode, partialText: ""));

    speechRecognizer.start(
      onResult: (text) {
        if (!isClosed) add(UpdateListeningTextEvent(text));
      },
      onFinalResult: (finalWord) {
        if (!isClosed) {
          add(StopListeningEvent());
          add(SendUserMessageEvent(finalWord));
        }
      },
    );
  }

  void _onUpdateListeningText(
    UpdateListeningTextEvent event,
    Emitter<ConversationState> emit,
  ) {
    if (state is ConversationListening) {
      emit(
        ConversationListening(mode: state.mode, partialText: event.partialText),
      );

      // Cancel the idle timer and stop any audio when user is actively speaking
      if (event.partialText.trim().isNotEmpty) {
        _cancelIdleTimer();
        _stopLipSync();
        if (ttsService.isSpeaking) {
          ttsService.stop();
        }
      }
    }
  }

  void _onStopListening(
    StopListeningEvent event,
    Emitter<ConversationState> emit,
  ) {
    if (speechRecognizer.isListening) {
      speechRecognizer.stop();
    }
    if (state is ConversationListening) {
      emit(ConversationIdle(mode: state.mode));
      _resetIdleTimer();
    }
  }

  Future<void> _onSendUserMessage(
    SendUserMessageEvent event,
    Emitter<ConversationState> emit,
  ) async {
    _cancelIdleTimer();
    _stopLipSync();
    await ttsService.stop();

    if (speechRecognizer.isListening) {
      speechRecognizer.stop();
    }

    emit(ConversationThinking(mode: state.mode));

    final userMessage = ChatMessage(role: ChatRole.user, content: event.text);

    try {
      final operatorName = cacheHelper.getOperatorName;

      final reply = await sendMessageUsecase(
        history: [..._chatHistory, userMessage],
        operatorName: operatorName,
      );

      _chatHistory
        ..add(userMessage)
        ..add(ChatMessage(role: ChatRole.assistant, content: reply.raw));

      if (_chatHistory.length > _maxHistory) {
        _chatHistory.removeRange(0, _chatHistory.length - _maxHistory);
      }

      avatarBloc.add(UpdateEmotionEvent(reply.emotions));

      emit(
        ConversationSpeaking(
          reply.text,
          reply.emotions,
          reply.color,
          mode: state.mode,
        ),
      );

      await ttsService.speak(reply.text, rate: reply.speechRate);
    } catch (e) {
      debugPrint('Error sending message: $e');
      _stopLipSync();
      await ttsService.stop();
      emit(
        ConversationError(
          'Failed to reach Amadeus. Try again.',
          mode: state.mode,
        ),
      );
      _resetIdleTimer();
      // Auto-restart listening after API error in voice mode
      if (state.mode == InteractionMode.voice) {
        add(StartListeningEvent());
      }
    }
  }

  void _onSpeakingFinished(
    SpeakingFinishedEvent event,
    Emitter<ConversationState> emit,
  ) {
    _stopLipSync();
    if (state is ConversationSpeaking) {
      emit(ConversationIdle(mode: state.mode));
      _resetIdleTimer();
      // Auto-restart listening after AI finishes speaking in voice mode
      if (state.mode == InteractionMode.voice) {
        add(StartListeningEvent());
      }
    }
  }

  Future<void> _onConversationFailed(
    ConversationFailedEvent event,
    Emitter<ConversationState> emit,
  ) async {
    _stopLipSync();
    await ttsService.stop();
    emit(ConversationError(event.message, mode: state.mode));
    _resetIdleTimer();
    // Auto-restart listening after error in voice mode
    if (state.mode == InteractionMode.voice) {
      add(StartListeningEvent());
    }
  }

  Future<void> _onChangeMode(
    ChangeInteractionModeEvent event,
    Emitter<ConversationState> emit,
  ) async {
    await cacheHelper.saveInteractionMode(event.newMode);

    // Stop speaking and mouth animation immediately when switching mode
    _stopLipSync();
    if (ttsService.isSpeaking) {
      await ttsService.stop();
    }

    if (event.newMode == InteractionMode.text && speechRecognizer.isListening) {
      speechRecognizer.stop();
    }

    emit(ConversationIdle(mode: event.newMode));
    _resetIdleTimer();

    // Auto-start listening when switching to voice mode
    if (event.newMode == InteractionMode.voice) {
      add(StartListeningEvent());
    }
  }

  Future<void> _onIdleTimeout(
    IdleTimeoutEvent event,
    Emitter<ConversationState> emit,
  ) async {
    _cancelIdleTimer();

    if (state is ConversationThinking ||
        state is ConversationSpeaking ||
        ttsService.isSpeaking) {
      return;
    }

    final random = Random();
    final isBoring = random.nextBool();
    final selectedEmotion =
        isBoring ? AvatarEmotion.boring : AvatarEmotion.checkingOnUser;

    final text = isBoring
        ? "Sigh... this is taking forever. Are we doing anything?"
        : "Operator, are you still there?";

    final color = isBoring ? "0xFF90A4AE" : "0xFF00E5FF";

    if (speechRecognizer.isListening) {
      speechRecognizer.stop();
    }

    avatarBloc.add(UpdateEmotionEvent([selectedEmotion]));

    emit(
      ConversationSpeaking(
        text,
        [selectedEmotion],
        color,
        mode: state.mode,
      ),
    );

    final rate = isBoring ? 0.35 : 0.5;
    await ttsService.speak(text, rate: rate);
  }

  @override
  Future<void> close() {
    _cancelIdleTimer();
    _stopLipSync();
    ttsService.stop();
    return super.close();
  }
}
