import 'package:amadeus_app/core/constants/app_keys.dart';
import 'package:amadeus_app/core/constants/interaction_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences sharedPreferences;

  CacheHelper({required this.sharedPreferences});
  Future<bool> saveOperatorName(String name) async {
    return await sharedPreferences.setString(AppKeys.operatorName, name);
  }

  Future<bool> setLoggedIn() async {
    return await sharedPreferences.setBool(AppKeys.isLoggedIn, true);
  }

  bool get isLoggedIn {
    return sharedPreferences.getBool(AppKeys.isLoggedIn) ?? false;
  }

  String get getOperatorName {
    return sharedPreferences.getString(AppKeys.operatorName) ?? 'Guest';
  }

  Future<bool> saveInteractionMode(InteractionMode interactionMode) async {
    return sharedPreferences.setString(
      AppKeys.isInteractionMode,
      interactionMode.name,
    );
  }

  InteractionMode get getInteractionMode {
    final mode = sharedPreferences.getString(AppKeys.isInteractionMode);
    if (mode == InteractionMode.text.name) {
      return InteractionMode.text;
    }
    return InteractionMode.voice;
  }
}
