part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

/// App just started, nothing has happened yet (e.g. splash/loading).
final class ConversationInitial extends ConversationState {}

/// Resting state: not listening, not thinking, not speaking.
/// The avatar is just waiting for the user to do something.
final class ConversationIdle extends ConversationState {}

/// Microphone is active, capturing the user's voice.
final class ConversationListening extends ConversationState {}

/// Waiting on a response from the AI backend.
final class ConversationThinking extends ConversationState {}

/// The avatar is currently speaking the AI's response.
final class ConversationSpeaking extends ConversationState {}

/// Something failed (e.g. the AI API call failed).
final class ConversationError extends ConversationState {
  final String message;
  ConversationError(this.message);
}
