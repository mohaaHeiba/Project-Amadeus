part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {
  final InteractionMode mode;

  const ConversationState({required this.mode});
}

final class ConversationInitial extends ConversationState {
  const ConversationInitial({required super.mode});
}

final class ConversationIdle extends ConversationState {
  const ConversationIdle({required super.mode});
}

final class ConversationListening extends ConversationState {
  final String partialText;
  const ConversationListening({this.partialText = "", required super.mode});
}

final class ConversationThinking extends ConversationState {
  const ConversationThinking({required super.mode});
}

final class ConversationSpeaking extends ConversationState {
  final String replyText;
  final AvatarEmotion emotion;
  final String color;

  const ConversationSpeaking(
    this.replyText,
    this.emotion,
    this.color, {
    required super.mode,
  });
}

final class ConversationError extends ConversationState {
  final String message;
  const ConversationError(this.message, {required super.mode});
}
