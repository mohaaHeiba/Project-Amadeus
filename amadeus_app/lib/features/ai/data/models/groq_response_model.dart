import 'dart:convert';

import 'package:amadeus_app/features/ai/data/models/choice_model.dart';
import 'package:amadeus_app/features/ai/data/models/usage_model.dart';

/// Represents the FULL raw response from the Groq API, top to
/// bottom, matching every field Groq actually sends back.
///
/// Raw JSON (full shape):
/// {
///   "id": "chatcmpl-...",
///   "object": "chat.completion",
///   "created": 1791069586,
///   "model": "openai/gpt-oss-20b",
///   "choices": [ {...} ],
///   "usage": { ... },
///   "system_fingerprint": "fp_...",
///   "service_tier": "on_demand"
/// }
class GroqResponseModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChoiceModel> choices;
  final UsageModel usage;
  final String? systemFingerprint;
  final String? serviceTier;

  const GroqResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    this.systemFingerprint,
    this.serviceTier,
  });

  factory GroqResponseModel.fromJson(Map<String, dynamic> json) {
    return GroqResponseModel(
      id: json['id'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      model: json['model'] as String,
      // "choices" is a List in the JSON — we map over each raw
      // item and delegate parsing to ChoiceModel.fromJson.
      choices: (json['choices'] as List<dynamic>)
          .map((item) => ChoiceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      usage: UsageModel.fromJson(json['usage'] as Map<String, dynamic>),
      systemFingerprint: json['system_fingerprint'] as String?,
      serviceTier: json['service_tier'] as String?,
    );
  }

  Map<String, dynamic> get parsedContent {
    final rawContent = choices.first.message.content;
    try {
      return jsonDecode(rawContent) as Map<String, dynamic>;
    } catch (e) {
      // Fallback in case the model returns malformed JSON or plain text
      return {'text': rawContent, 'emotion': 'neutral', 'color': '0x00000000'};
    }
  }

  // 1. Getter for All
  String get reply => choices.first.message.content;

  // 2. Getter for the text
  String get replyText => parsedContent['text'] ?? '';

  // 3. Getter for the emotion
  String get replyemotion => parsedContent['emotion'] ?? 'neutral';
  // 3. Getter for the emotion
  String get replyColor => parsedContent['color'] ?? '0x00000000';
}
