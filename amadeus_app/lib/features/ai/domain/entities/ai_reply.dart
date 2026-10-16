import 'package:amadeus_app/core/constants/avatar_emotion.dart';

class AiReply {
  final String text;
  final List<AvatarEmotion> emotions;
  final String color;
  final double speechRate;
  final String raw;

  const AiReply(
    this.color, {
    required this.text,
    required this.emotions,
    this.speechRate = 0.5,
    required this.raw,
  });
}
