import 'package:amadeus_app/constants/assets.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/splash/presentation/widgets/glitch_paint.dart';
import 'package:flutter/material.dart';

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
    )..repeat();
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
      backgroundColor: AppColors.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(Assets.imagesLogo1, width: 200),

          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                size: size,
                painter: GlitchPaint(
                  progress: controller.value,
                  seed: (controller.value * 20).toInt(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
