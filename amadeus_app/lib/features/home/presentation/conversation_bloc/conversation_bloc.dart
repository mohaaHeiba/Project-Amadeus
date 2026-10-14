import 'package:amadeus_app/core/constants/avatar_emotion.dart';
import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/features/ai/domain/entities/chat_message.dart';
import 'package:amadeus_app/features/ai/domain/usecases/send_message_usecase.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
import 'package:amadeus_app/features/speech/domain/speech_recognizer.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final SendMessageUsecase sendMessageUsecase;
  final CacheHelper cacheHelper;
  final SpeechRecognizer speechRecognizer;
  final AvatarBloc avatarBloc;

  final List<ChatMessage> _chatHistory = [];
  static const int _maxHistory = 20;

  ConversationBloc({
    required this.sendMessageUsecase,
    required this.cacheHelper,
    required this.speechRecognizer,
    required this.avatarBloc,
  }) : super(ConversationInitial(mode: cacheHelper.getInteractionMode)) {
    on<AppReadyEvent>(_onAppReady);

    on<StartListeningEvent>(_onStartListening);
    on<UpdateListeningTextEvent>(_onUpdateListeningText);
    on<StopListeningEvent>(_onStopListening);

    on<SendUserMessageEvent>(_onSendUserMessage, transformer: droppable());
    on<SpeakingFinishedEvent>(_onSpeakingFinished);
    on<ConversationFailedEvent>(_onConversationFailed);
    on<ChangeInteractionModeEvent>(_onChangeMode);
  }

  void _onAppReady(AppReadyEvent event, Emitter<ConversationState> emit) {
    emit(ConversationIdle(mode: state.mode));
  }

  void _onStartListening(
    StartListeningEvent event,
    Emitter<ConversationState> emit,
  ) {
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
    }
  }

  Future<void> _onSendUserMessage(
    SendUserMessageEvent event,
    Emitter<ConversationState> emit,
  ) async {
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

      avatarBloc.add(UpdateEmotionEvent(reply.emotion));

      emit(
        ConversationSpeaking(
          reply.text,
          reply.emotion,
          reply.color,
          mode: state.mode,
        ),
      );
    } catch (e) {
      debugPrint('Error sending message: $e');
      emit(
        ConversationError(
          'Failed to reach Amadeus. Try again.',
          mode: state.mode,
        ),
      );
    }
  }

  void _onSpeakingFinished(
    SpeakingFinishedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationIdle(mode: state.mode));
  }

  void _onConversationFailed(
    ConversationFailedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationError(event.message, mode: state.mode));
  }

  Future<void> _onChangeMode(
    ChangeInteractionModeEvent event,
    Emitter<ConversationState> emit,
  ) async {
    await cacheHelper.saveInteractionMode(event.newMode);

    if (event.newMode == InteractionMode.text && speechRecognizer.isListening) {
      speechRecognizer.stop();
    }

    emit(ConversationIdle(mode: event.newMode));
  }
}
