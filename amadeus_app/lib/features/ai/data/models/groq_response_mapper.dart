import 'dart:convert';

import 'package:amadeus_app/core/constants/avatar_emotion.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';
import 'package:amadeus_app/features/ai/domain/entities/ai_reply.dart';

extension GroqResponseMapper on GroqResponseModel {
  AiReply toAiReply() {
    if (choices.isEmpty) {
      return AiReply(
        '0xFF000000',
        text: 'Error: No choices returned.',
        emotion: AvatarEmotion.neutral,
        raw: '',
      );
    }

    final raw = choices.first.message.content;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return AiReply(
        json['color'] as String? ?? '0xFF000000',
        text: json['text'] as String? ?? raw,
        emotion: AvatarEmotion.fromName(json['emotion'] as String?),
        raw: raw,
      );
    } catch (_) {
      return AiReply(
        '0xFF000000',
        text: raw,
        emotion: AvatarEmotion.neutral,
        raw: raw,
      );
    }
  }
}
