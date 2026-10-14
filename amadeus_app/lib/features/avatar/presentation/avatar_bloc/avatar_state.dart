part of 'avatar_bloc.dart';

@immutable
class AvatarState {
  final bool isAngry;
  final bool isHandToChest;
  final bool isBlushing;
  final bool isShakingHead;
  final bool isCheckingOnUser;
  final double mouthValue;

  const AvatarState({
    this.isAngry = false,
    this.isHandToChest = false,
    this.isBlushing = false,
    this.isShakingHead = false,
    this.isCheckingOnUser = false,
    this.mouthValue = 0.0,
  });

  AvatarState copyWith({
    bool? isAngry,
    bool? isHandToChest,
    bool? isBlushing,
    bool? isShakingHead,
    bool? isCheckingOnUser,
    double? mouthValue,
  }) {
    return AvatarState(
      isAngry: isAngry ?? this.isAngry,
      isHandToChest: isHandToChest ?? this.isHandToChest,
      isBlushing: isBlushing ?? this.isBlushing,
      isShakingHead: isShakingHead ?? this.isShakingHead,
      isCheckingOnUser: isCheckingOnUser ?? this.isCheckingOnUser,
      mouthValue: mouthValue ?? this.mouthValue,
    );
  }

  factory AvatarState.fromEmotions(
    List<AvatarEmotion> emotions, {
    double mouthValue = 0.0,
  }) {
    return AvatarState(
      isAngry: emotions.contains(AvatarEmotion.angry),
      isHandToChest: emotions.contains(AvatarEmotion.handToChest),
      isBlushing: emotions.contains(AvatarEmotion.blushing),
      isShakingHead: emotions.contains(AvatarEmotion.shakingHead),
      isCheckingOnUser: emotions.contains(AvatarEmotion.checkingOnUser),
      mouthValue: mouthValue,
    );
  }

  Map<String, dynamic> toRiveInputsMap() {
    return {
      RiveInputNames.angry: isAngry,
      RiveInputNames.handToChest: isHandToChest,
      RiveInputNames.isBlushing: isBlushing,
      RiveInputNames.shakingHead: isShakingHead,
      RiveInputNames.checkingOnUser: isCheckingOnUser,
      RiveInputNames.mouthValue: mouthValue,
    };
  }

  factory AvatarState.fromRiveInputsMap(Map<String, dynamic> map) {
    return AvatarState(
      isAngry: map[RiveInputNames.angry] as bool? ?? false,
      isHandToChest: map[RiveInputNames.handToChest] as bool? ?? false,
      isBlushing: map[RiveInputNames.isBlushing] as bool? ?? false,
      isShakingHead: map[RiveInputNames.shakingHead] as bool? ?? false,
      isCheckingOnUser: map[RiveInputNames.checkingOnUser] as bool? ?? false,
      mouthValue: (map[RiveInputNames.mouthValue] as num?)?.toDouble() ?? 0.0,
    );
  }
}
