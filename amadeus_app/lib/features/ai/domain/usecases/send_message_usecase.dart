import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class SendMessageUsecase {
  final AiRepository aiRepository;

  SendMessageUsecase({required this.aiRepository});

  Future<GroqResponseModel> post(String text) async {
    return aiRepository.post(text);
  }
}
