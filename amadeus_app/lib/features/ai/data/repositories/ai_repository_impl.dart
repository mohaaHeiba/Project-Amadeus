import 'package:amadeus_app/features/ai/data/datasources/groq_datasource.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_mapper.dart';
import 'package:amadeus_app/features/ai/domain/entities/ai_reply.dart';
import 'package:amadeus_app/features/ai/domain/entities/chat_message.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final GroqDatasource groqDatasource;

  AiRepositoryImpl({required this.groqDatasource});

  @override
  Future<AiReply> sendMessage(List<ChatMessage> messages) async {
    final response = await groqDatasource.post(
      messages.map((m) => {'role': m.role.name, 'content': m.content}).toList(),
    );
    return response.toAiReply();
  }
}
