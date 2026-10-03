import 'package:amadeus_app/core/services/cache_helper.dart';
import 'package:amadeus_app/core/services/service_locator.dart';
import 'package:amadeus_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amadeus_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
import 'package:amadeus_app/features/avatar/presentation/conversation_bloc/conversation_bloc.dart';
import 'package:amadeus_app/features/home/presentation/screens/home_screen.dart';
import 'package:amadeus_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';

  // static const String details = '/onbording';

  static final GoRouter router = GoRouter(
    initialLocation: sl<CacheHelper>().isLoggedIn ? home : splash,

    // errorBuilder: (context, state) =>
    // const Scaffold(body: Center(child: Text('Page not found!'))),
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
            BlocProvider(create: (context) => ConversationBloc()),
          ],
          child: const HomeScreen(),
        ),
      ),

      // GoRoute(
      //   path: details,
      //   // builder: (context, state) => const DetailsPage(),
      // ),
    ],
  );
}
