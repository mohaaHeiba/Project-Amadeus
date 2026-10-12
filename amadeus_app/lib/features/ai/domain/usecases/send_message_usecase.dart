import 'package:amadeus_app/features/ai/data/models/chat_message.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class SendMessageUsecase {
  final AiRepository aiRepository;

  SendMessageUsecase({required this.aiRepository});

  Future<GroqResponseModel> post(List<ChatMessage> messages) async {
    return aiRepository.post(messages);
  }
}
