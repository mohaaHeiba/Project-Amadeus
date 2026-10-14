part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class AppReadyEvent extends ConversationEvent {}

final class StartListeningEvent extends ConversationEvent {}

final class StopListeningEvent extends ConversationEvent {}

final class UpdateListeningTextEvent extends ConversationEvent {
  final String partialText;
  UpdateListeningTextEvent(this.partialText);
}

final class SendUserMessageEvent extends ConversationEvent {
  final String text;
  SendUserMessageEvent(this.text);
}

final class ChangeInteractionModeEvent extends ConversationEvent {
  final InteractionMode newMode;
  ChangeInteractionModeEvent(this.newMode);
}

final class SpeakingFinishedEvent extends ConversationEvent {}

final class ConversationFailedEvent extends ConversationEvent {
  final String message;
  ConversationFailedEvent(this.message);
}

final class ResetIdleTimerEvent extends ConversationEvent {}

final class IdleTimeoutEvent extends ConversationEvent {}
