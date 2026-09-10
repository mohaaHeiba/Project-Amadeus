import 'package:amadeus_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  // static const String details = '/onbording';

  static final GoRouter router = GoRouter(
    initialLocation: splash,

    // errorBuilder: (context, state) =>
    // const Scaffold(body: Center(child: Text('Page not found!'))),
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      // GoRoute(
      //   path: details,
      //   // builder: (context, state) => const DetailsPage(),
      // ),
    ],
  );
}
