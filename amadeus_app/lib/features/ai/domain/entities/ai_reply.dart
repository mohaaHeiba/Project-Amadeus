import 'package:amadeus_app/core/constants/avatar_emotion.dart';

class AiReply {
  final String text;
  final List<AvatarEmotion> emotions;
  final String color;

  final String raw;

  const AiReply(
    this.color, {
    required this.text,
    required this.emotions,
    required this.raw,
  });
}
