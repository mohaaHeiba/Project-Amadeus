import 'package:amadeus_app/features/ai/data/model/chat_message.dart';
import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';

abstract class AiRepository {
  Future<GroqResponseModel> post(List<ChatMessage> messages);
}
