part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {
  final InteractionMode mode;

  const ConversationState({required this.mode});
}

/// App just started, nothing has happened yet (e.g. splash/loading).
final class ConversationInitial extends ConversationState {
  const ConversationInitial({required super.mode});
}

/// Resting state: not listening, not thinking, not speaking.
/// The avatar is just waiting for the user to do something.
final class ConversationIdle extends ConversationState {
  const ConversationIdle({required super.mode});
}

/// Microphone is active, capturing the user's voice.
final class ConversationListening extends ConversationState {
  const ConversationListening({required super.mode});
}

/// Waiting on a response from the AI backend.
final class ConversationThinking extends ConversationState {
  const ConversationThinking({required super.mode});
}

/// The avatar is currently speaking the AI's response.
/// Now carries the actual reply text so the UI can display it.
final class ConversationSpeaking extends ConversationState {
  final String replyText;
  final String emotion;
  final String color;

  const ConversationSpeaking(
    this.replyText,
    this.emotion,
    this.color, {
    required super.mode,
  });
}

/// Something failed (e.g. the AI API call failed).
final class ConversationError extends ConversationState {
  final String message;
  const ConversationError(this.message, {required super.mode});
}
