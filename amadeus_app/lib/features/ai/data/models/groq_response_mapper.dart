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
        emotions: [AvatarEmotion.neutral],
        speechRate: 0.5,
        raw: '',
      );
    }

    final raw = choices.first.message.content;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final rate = (json['speech_rate'] as num?)?.toDouble() ?? 0.5;
      return AiReply(
        json['color'] as String? ?? '0xFF000000',
        text: json['text'] as String? ?? raw,
        emotions: AvatarEmotion.fromList(json['emotions'] as List<dynamic>?),
        speechRate: rate.clamp(0.2, 1.0),
        raw: raw,
      );
    } catch (_) {
      return AiReply(
        '0xFF000000',
        text: raw,
        emotions: [AvatarEmotion.neutral],
        speechRate: 0.5,
        raw: raw,
      );
    }
  }
}
