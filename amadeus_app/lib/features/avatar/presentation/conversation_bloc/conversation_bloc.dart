import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<AppReadyEvent>(_onAppReady);
    on<ToggleListeningEvent>(_onToggleListening);
    on<StartThinkingEvent>(_onStartThinking);
    on<ResponseReceivedEvent>(_onResponseReceived);
    on<SpeakingFinishedEvent>(_onSpeakingFinished);
    on<ConversationFailedEvent>(_onConversationFailed);
  }

  void _onAppReady(AppReadyEvent event, Emitter<ConversationState> emit) {
    emit(ConversationIdle());
  }

  void _onToggleListening(
    ToggleListeningEvent event,
    Emitter<ConversationState> emit,
  ) {
    if (event.isListening) {
      emit(ConversationListening());
    } else {
      emit(ConversationIdle());
    }
  }

  void _onStartThinking(
    StartThinkingEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationThinking());
  }

  void _onResponseReceived(
    ResponseReceivedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationSpeaking());
  }

  void _onSpeakingFinished(
    SpeakingFinishedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationIdle());
  }

  void _onConversationFailed(
    ConversationFailedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(ConversationError(event.message));
  }
}
