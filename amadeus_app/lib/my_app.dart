import 'package:amadeus_app/core/routes/app_routes.dart';
import 'package:amadeus_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Amadeus',
      routerConfig: AppRoutes.router,
      theme: AppTheme.darkTheme,
    );
  }
}
