import 'package:amadeus_app/features/ai/domain/entities/ai_reply.dart';
import 'package:amadeus_app/features/ai/domain/entities/chat_message.dart';
import 'package:amadeus_app/features/ai/domain/prompts/amadeus_system_prompt.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class SendMessageUsecase {
  final AiRepository aiRepository;

  SendMessageUsecase({required this.aiRepository});

  Future<AiReply> call({
    required List<ChatMessage> history,
    required String operatorName,
  }) {
    final messages = [
      ChatMessage(
        role: ChatRole.system,
        content: buildSystemPrompt(operatorName: operatorName),
      ),
      ...history,
    ];
    return aiRepository.sendMessage(messages);
  }
}
