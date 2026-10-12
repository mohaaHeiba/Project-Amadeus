/// Represents the "usage" object — how many tokens this request
/// consumed, and how long it took.
///
/// Raw JSON:
/// "usage": {
///   "queue_time": 0.016903041,
///   "prompt_tokens": 72,
///   "prompt_time": 0.003864386,
///   "completion_tokens": 47,
///   "completion_time": 0.048922106,
///   "total_tokens": 119,
///   "total_time": 0.052786492
/// }
class UsageModel {
  final double queueTime;
  final int promptTokens;
  final double promptTime;
  final int completionTokens;
  final double completionTime;
  final int totalTokens;
  final double totalTime;

  const UsageModel({
    required this.queueTime,
    required this.promptTokens,
    required this.promptTime,
    required this.completionTokens,
    required this.completionTime,
    required this.totalTokens,
    required this.totalTime,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) {
    return UsageModel(
      queueTime: (json['queue_time'] as num).toDouble(),
      promptTokens: json['prompt_tokens'] as int,
      promptTime: (json['prompt_time'] as num).toDouble(),
      completionTokens: json['completion_tokens'] as int,
      completionTime: (json['completion_time'] as num).toDouble(),
      totalTokens: json['total_tokens'] as int,
      totalTime: (json['total_time'] as num).toDouble(),
    );
  }
}
