part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

/// The app finished loading/setup, ready to go idle.
final class AppReadyEvent extends ConversationEvent {}

/// The user started or stopped using the microphone.
final class ToggleListeningEvent extends ConversationEvent {
  final bool isListening;
  ToggleListeningEvent(this.isListening);
}

/// The user finished speaking/typing — we now wait on the AI.
final class StartThinkingEvent extends ConversationEvent {}

/// The AI responded successfully with some text to speak.
final class ResponseReceivedEvent extends ConversationEvent {
  final String response;
  ResponseReceivedEvent(this.response);
}

/// The avatar finished speaking the response, back to idle.
final class SpeakingFinishedEvent extends ConversationEvent {}

/// Something failed (e.g. the AI API call failed).
final class ConversationFailedEvent extends ConversationEvent {
  final String message;
  ConversationFailedEvent(this.message);
}
