import 'package:amadeus_app/constants/assets.dart';
import 'package:amadeus_app/core/routes/app_router.dart';
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
          context.go(AppRouter.auth);
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
      backgroundColor: AppColors.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: size, painter: GridPainter()),

          // Gradient Fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromARGB(
                      255,
                      85,
                      73,
                      58,
                    ).withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
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
