import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GroqDatasource {
  Future<GroqResponseModel> post(List<Map<String, String>> messages);
}

class GroqDatasourceImpl implements GroqDatasource {
  final Dio dio;

  GroqDatasourceImpl({required this.dio});

  final apiUrl = dotenv.get('API_URL');
  final api = dotenv.get('API');

  @override
  Future<GroqResponseModel> post(List<Map<String, String>> messages) async {
    final res = await dio.post(
      apiUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api',
        },
      ),
      data: {
        'model': 'openai/gpt-oss-20b',
        'messages': messages,
        'response_format': {'type': 'json_object'},
      },
    );
    return GroqResponseModel.fromJson(res.data);
  }
}
