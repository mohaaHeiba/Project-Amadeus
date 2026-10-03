import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class SendMessageUsecase {
  final AiRepository aiRepository;

  SendMessageUsecase({required this.aiRepository});

  Future<void> post(String text) async {
    return aiRepository.post(text);
  }
}
