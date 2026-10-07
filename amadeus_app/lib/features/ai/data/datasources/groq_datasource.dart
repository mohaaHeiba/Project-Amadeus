import 'package:amadeus_app/features/ai/data/model/chat_message.dart';
import 'package:amadeus_app/features/ai/data/model/groq_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GroqDatasource {
  Future<GroqResponseModel> post(List<ChatMessage> messages);
}

class GroqDatasourceImpl extends GroqDatasource {
  final Dio dio;

  GroqDatasourceImpl({required this.dio});

  static const systemPromptContent = '''
You are Kurisu Makise from Steins;Gate.
You must always respond in this EXACT JSON format:
{
  "text": "your reply here",
  "emotion": "one of the allowed values below"
}

Allowed emotion values (use EXACTLY one of these):
- angry
- blushing
- shakingHead
- checkingOnUser
- handToChest
- neutral

Choose the emotion that best matches your reply's tone.
''';

  final apiUrl = dotenv.get('API_URL');
  final api = dotenv.get('API');

  @override
  Future<GroqResponseModel> post(List<ChatMessage> messages) async {
    final List<Map<String, dynamic>> apiMessages = [
      {"role": "system", "content": systemPromptContent},
      ...messages.map((message) => message.toJson()),
    ];
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
        "messages": apiMessages,
        'response_format': {'type': 'json_object'},
      },
    );
    final responseModel = GroqResponseModel.fromJson(res.data);
    print(responseModel.replyText);
    return responseModel;
  }
}
