import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/core/widgets/custom_background/widgets/grid_painter.dart';
import 'package:flutter/material.dart';

Widget customBackground(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return Stack(
    children: [
      Positioned.fill(
        child: CustomPaint(size: size, painter: GridPainter()),
      ),

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
    ],
  );
}
