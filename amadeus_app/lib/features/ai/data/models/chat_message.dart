class ChatMessage {
  final String role;
  final String content;

  const ChatMessage({required this.role, required this.content});

  Map<String, String> toJson() {
    return {'role': role, 'content': content};
  }
}
