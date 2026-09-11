import 'package:amadeus_app/core/constants/assets.dart';
import 'package:amadeus_app/core/routes/app_routes.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/splash/presentation/widgets/glitch_painter.dart';
import 'package:amadeus_app/features/splash/presentation/widgets/grid_painter.dart';
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
          CustomPaint(size: size, painter: GridPainter()),

          // Ambient Warm Amber Glow at Top
          Positioned(
            top: -120,
            left: 0,
            right: 0,
            height: 380,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 0.9,
                  colors: [
                    AppColors.primaryContainer.withValues(alpha: 0.14),
                    AppColors.secondaryContainer.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Subtle Bottom Dark Fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.scaffoldBackground, Colors.transparent],
                ),
              ),
            ),
          ),

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
