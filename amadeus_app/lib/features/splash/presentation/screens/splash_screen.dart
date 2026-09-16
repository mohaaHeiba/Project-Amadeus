import 'package:amadeus_app/core/constants/assets.dart';
import 'package:amadeus_app/core/routes/app_routes.dart';
import 'package:amadeus_app/core/widgets/custom_background.dart';
import 'package:amadeus_app/features/splash/presentation/widgets/glitch_painter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    if (mounted) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.go(AppRoutes.auth);
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          customBackground(context),

          Image.asset(Assets.imagesLogo1, width: 200),

          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                size: size,
                painter: GlitchPaint(
                  progress: controller.value,
                  seed: (controller.value * 18).toInt(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
