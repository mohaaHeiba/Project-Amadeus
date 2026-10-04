import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GroqDatasource {
  Future<GroqResponseModel> post(String text);
}

class GroqDatasourceImpl extends GroqDatasource {
  final Dio dio;

  GroqDatasourceImpl({required this.dio});

  final apiUrl = dotenv.get('API_URL');
  final api = dotenv.get('API');

  @override
  Future<GroqResponseModel> post(String text) async {
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
        "messages": [
          {"role": "user", "content": text},
        ],
      },
    );
    final responseModel = GroqResponseModel.fromJson(res.data);
    print(responseModel.replyText);
    return responseModel;
  }
}
