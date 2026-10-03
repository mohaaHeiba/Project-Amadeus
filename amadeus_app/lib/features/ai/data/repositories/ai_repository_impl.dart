import 'package:amadeus_app/features/ai/data/datasources/groq_datasource.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl extends AiRepository {
  final GroqDatasource groqDatasource;

  AiRepositoryImpl({required this.groqDatasource});

  @override
  Future<void> post(String text) async {
    try {
      await groqDatasource.post(text);
    } catch (e) {
      print(e);
    }
  }
}
