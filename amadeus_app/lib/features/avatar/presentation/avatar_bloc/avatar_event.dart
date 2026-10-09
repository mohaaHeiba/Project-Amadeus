part of 'avatar_bloc.dart';

@immutable
sealed class AvatarEvent {}

/// Toggle the "angry" expression on/off.
final class ToggleAngryEvent extends AvatarEvent {
  final bool value;
  ToggleAngryEvent(this.value);
}

/// Toggle the "hand to chest" gesture on/off.
final class ToggleHandToChestEvent extends AvatarEvent {
  final bool value;
  ToggleHandToChestEvent(this.value);
}

/// Toggle the "blushing" expression on/off.
final class ToggleBlushingEvent extends AvatarEvent {
  final bool value;
  ToggleBlushingEvent(this.value);
}

/// Toggle the "shaking head" (no) animation on/off.
final class ToggleShakingHeadEvent extends AvatarEvent {
  final bool value;
  ToggleShakingHeadEvent(this.value);
}

/// Toggle the "are you okay" head-tilt animation on/off.
final class ToggleCheckingOnUserEvent extends AvatarEvent {
  final bool value;
  ToggleCheckingOnUserEvent(this.value);
}

final class UpdateEmotionEvent extends AvatarEvent {
  final String emotion;

  UpdateEmotionEvent(this.emotion);
}

/// Update the mouth value (0-100) for lip-sync.
final class UpdateMouthValueEvent extends AvatarEvent {
  final double value;
  UpdateMouthValueEvent(this.value);
}
