import 'package:amadeus_app/features/ai/data/models/choice_model.dart';
import 'package:amadeus_app/features/ai/data/models/usage_model.dart';

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
      choices: (json['choices'] as List<dynamic>)
          .map((item) => ChoiceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      usage: UsageModel.fromJson(json['usage'] as Map<String, dynamic>),
      systemFingerprint: json['system_fingerprint'] as String?,
      serviceTier: json['service_tier'] as String?,
    );
  }
}
