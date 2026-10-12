/// Represents the "message" object nested inside each choice.
///
/// Raw JSON:
/// "message": {
///   "role": "assistant",
///   "content": "Hey there! ...",
///   "reasoning": "The user just said \"hey\"..."
/// }
class MessageModel {
  final String role;
  final String content;
  final String? reasoning;

  const MessageModel({
    required this.role,
    required this.content,
    this.reasoning,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
      // reasoning isn't always present, so it's nullable.
      reasoning: json['reasoning'] as String?,
    );
  }
}
