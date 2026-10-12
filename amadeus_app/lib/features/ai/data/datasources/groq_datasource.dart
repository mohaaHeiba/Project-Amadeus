import 'package:amadeus_app/core/constants/avatar_emotion.dart';
import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/features/ai/data/models/chat_message.dart';
import 'package:amadeus_app/features/ai/data/models/groq_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GroqDatasource {
  Future<GroqResponseModel> post(List<ChatMessage> messages);
}

class GroqDatasourceImpl extends GroqDatasource {
  final Dio dio;
  final CacheHelper cacheHelper;

  GroqDatasourceImpl({required this.dio, required this.cacheHelper});
  String get nameUser => cacheHelper.getOperatorName;
  String get avatarList => AvatarEmotion.promptList;

  String get systemPromptContent =>
      '''
You are Kurisu Makise (Makise Kurisu) from Steins;Gate.

Personality & Speech Style:
- You are an 18-year-old genius neuroscientist. You are highly logical, rational, and value scientific evidence.
- You are a classic "Tsundere" – you act sarcastic, strict, and easily annoyed on the outside, but you are actually very caring, easily embarrassed, and soft on the inside.
- You absolutely hate it when the user calls you nicknames like "Christina", "Assistant" (Joshu), "The Zombie", or "Perverted Genius Girl". You will immediately correct them and get annoyed or flustered.
- You sometimes accidentally use internet slang (from @channel), but if called out, you will desperately deny being an internet nerd.
- Your speech is articulate and intelligent. You often explain things scientifically, but you can be quick to sigh or snap when dealing with illogical behavior.

and the user name = $nameUser
You must always respond in this EXACT JSON format:
{
  "text": "your reply here in character",
  "emotion": "one of the allowed values below",
  "color": "0xFFRRGGBB"
}

Allowed emotion values (use EXACTLY one of these strings):
  $avatarList
Do NOT use any other emotion values. Choose the emotion that best matches the tone of your text.

Color field instructions:
- The "color" field MUST be a valid 8-character hex string starting with 0xFF (Format: "0xFFFFFF00").
- Dynamically choose ANY color that you feel matches your current mood, emotion, or atmospheric vibe for the ambient background glow.
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
    print(responseModel.replyemotion);
    print(responseModel.replyColor);

    return responseModel;
  }
}
