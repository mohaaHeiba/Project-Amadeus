import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/features/ai/data/model/chat_message.dart';
import 'package:amadeus_app/features/ai/domain/usecases/send_message_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final SendMessageUsecase sendMessageUsecase;
  final CacheHelper cacheHelper;
  final List<ChatMessage> chatHistory = [];

  ConversationBloc({
    required this.sendMessageUsecase,
    required this.cacheHelper,
  }) : super(ConversationInitial(mode: cacheHelper.getInteractionMode)) {
    on<AppReadyEvent>(_onAppReady);
    on<ToggleListeningEvent>(_onToggleListening);
    on<SendUserMessageEvent>(_onSendUserMessage);
    on<SpeakingFinishedEvent>(_onSpeakingFinished);
    on<ConversationFailedEvent>(_onConversationFailed);
    on<ChangeInteractionModeEvent>(_onChangeMode);
  }

  void _onAppReady(AppReadyEvent event, Emitter<ConversationState> emit) {
    emit(ConversationIdle(mode: state.mode));
  }

  void _onToggleListening(
    ToggleListeningEvent event,
    Emitter<ConversationState> emit,
  ) {
    if (event.isListening) {
      emit(ConversationListening(mode: state.mode));
    } else {
      emit(ConversationIdle(mode: state.mode));
    }
  }

  Future<void> _onSendUserMessage(
    SendUserMessageEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationThinking(mode: state.mode));

    chatHistory.addAll(event.messages);
    try {
      final response = await sendMessageUsecase.post(chatHistory);

      chatHistory.add(
        ChatMessage(
          role: 'assistant',
          content: response.choices.first.message.content,
        ),
      );

      emit(ConversationSpeaking(response.replyText, mode: state.mode));
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
  // ====================================

  Future<void> _onChangeMode(
    ChangeInteractionModeEvent event,
    Emitter<ConversationState> emit,
  ) async {
    await cacheHelper.saveInteractionMode(event.newMode);
    emit(ConversationIdle(mode: event.newMode));
  }
}
