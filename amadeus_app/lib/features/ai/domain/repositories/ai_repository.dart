import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';

abstract class AiRepository {
  Future<GroqResponseModel> post(String text);
}
