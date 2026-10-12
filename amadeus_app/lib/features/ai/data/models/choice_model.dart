import 'package:amadeus_app/features/ai/data/models/message_model.dart';

/// Represents a single item in the "choices" array.
///
/// Raw JSON:
/// {
///   "index": 0,
///   "message": { ... },
///   "logprobs": null,
///   "finish_reason": "stop"
/// }
class ChoiceModel {
  final int index;
  final MessageModel message;
  final String finishReason;

  const ChoiceModel({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      index: json['index'] as int,
      // This is where the "nested model" pattern shows: we don't
      // parse the message fields here, we delegate to MessageModel.
      message: MessageModel.fromJson(json['message'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String,
    );
  }
}
