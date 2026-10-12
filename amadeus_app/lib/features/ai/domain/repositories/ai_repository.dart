import 'package:amadeus_app/features/ai/domain/entities/ai_reply.dart';
import 'package:amadeus_app/features/ai/domain/entities/chat_message.dart';

abstract class AiRepository {
  Future<AiReply> sendMessage(List<ChatMessage> messages);
}
