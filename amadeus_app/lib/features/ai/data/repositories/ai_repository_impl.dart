import 'package:amadeus_app/features/ai/data/datasources/groq_datasource.dart';
import 'package:amadeus_app/features/ai/data/models/chat_message.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl extends AiRepository {
  final GroqDatasource groqDatasource;

  AiRepositoryImpl({required this.groqDatasource});

  @override
  Future<GroqResponseModel> post(List<ChatMessage> messages) async {
    return await groqDatasource.post(messages);
  }
}
