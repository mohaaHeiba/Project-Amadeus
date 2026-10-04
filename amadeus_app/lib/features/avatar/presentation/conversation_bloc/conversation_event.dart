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

/// The user sent a message (typed or spoken) — this is what
/// actually triggers the AI call.
final class SendUserMessageEvent extends ConversationEvent {
  final String text;
  SendUserMessageEvent(this.text);
}

final class ChangeInteractionModeEvent extends ConversationEvent {
  final InteractionMode newMode;
  ChangeInteractionModeEvent(this.newMode);
}

/// The avatar finished speaking the response, back to idle.
final class SpeakingFinishedEvent extends ConversationEvent {}

/// Something failed (e.g. the AI API call failed).
final class ConversationFailedEvent extends ConversationEvent {
  final String message;
  ConversationFailedEvent(this.message);
}
