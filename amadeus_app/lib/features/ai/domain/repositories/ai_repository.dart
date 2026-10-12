import 'package:amadeus_app/features/ai/data/models/chat_message.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';

abstract class AiRepository {
  Future<GroqResponseModel> post(List<ChatMessage> messages);
}
