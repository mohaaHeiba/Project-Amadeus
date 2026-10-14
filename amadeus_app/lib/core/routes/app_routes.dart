import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/core/services/service_locator.dart';
import 'package:amadeus_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amadeus_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
import 'package:amadeus_app/features/home/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:amadeus_app/features/home/presentation/screens/home_screen.dart';
import 'package:amadeus_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: sl<CacheHelper>().isLoggedIn ? home : splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: auth,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const AuthScreen(),
        ),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AvatarBloc()),

            BlocProvider(
              create: (context) => ConversationBloc(
                sendMessageUsecase: sl(),
                cacheHelper: sl(),
                speechRecognizer: sl(),
                avatarBloc: context.read<AvatarBloc>(),
              ),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
