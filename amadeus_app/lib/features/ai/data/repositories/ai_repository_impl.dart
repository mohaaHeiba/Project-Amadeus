import 'package:amadeus_app/features/ai/data/datasources/groq_datasource.dart';
import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl extends AiRepository {
  final GroqDatasource groqDatasource;

  AiRepositoryImpl({required this.groqDatasource});

  @override
  Future<GroqResponseModel> post(String text) async {
    return await groqDatasource.post(text);
  }
}
