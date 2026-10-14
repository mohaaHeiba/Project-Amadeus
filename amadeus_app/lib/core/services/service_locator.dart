import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/features/ai/data/datasources/groq_datasource.dart';
import 'package:amadeus_app/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:amadeus_app/features/ai/domain/repositories/ai_repository.dart';
import 'package:amadeus_app/features/ai/domain/usecases/send_message_usecase.dart';
import 'package:amadeus_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:amadeus_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:amadeus_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:amadeus_app/features/auth/domain/usecases/save_operator_name_usecase.dart';
import 'package:amadeus_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amadeus_app/features/speech/data/speech_recognizer_impl.dart';
import 'package:amadeus_app/features/speech/domain/speech_recognizer.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // 1. External (SharedPreferences)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //--------------------------------------------------------
  //----------------------AUTH------------------------------
  //--------------------------------------------------------

  // 2. Core (CacheHelper)
  sl.registerLazySingleton(() => CacheHelper(sharedPreferences: sl()));

  // 3. Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(cacheHelper: sl()),
  );

  // 4. Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  // 5. Use Cases
  sl.registerLazySingleton(() => SaveOperatorNameUsecase(sl()));

  // 6. BLoCs
  sl.registerFactory(() => AuthBloc(saveOperatorNameUseCase: sl()));

  //--------------------------------------------------------
  //----------------------AI--------------------------------
  //--------------------------------------------------------

  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    ),
  );

  sl.registerLazySingleton<GroqDatasource>(() => GroqDatasourceImpl(dio: sl()));

  sl.registerLazySingleton<AiRepository>(
    () => AiRepositoryImpl(groqDatasource: sl()),
  );

  sl.registerLazySingleton(() => SendMessageUsecase(aiRepository: sl()));

  //--------------------------------------------------------
  //----------------------SPEECH----------------------------
  //--------------------------------------------------------
  sl.registerLazySingleton<SpeechRecognizer>(() => SpeechRecognizerImpl());
}
