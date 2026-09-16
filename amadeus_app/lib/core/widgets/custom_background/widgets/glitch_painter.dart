import 'dart:math';

import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

final class GlitchPaint extends CustomPainter {
  final double progress;
  final int seed;

  GlitchPaint({required this.progress, required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress > 0.95) return;

    final random = Random(seed);

    final bgPaint = Paint()..color = AppColors.background;
    final amberPaint = Paint()..color = AppColors.primary;

    int blockCount = ((1.0 - progress) * 45).toInt();

    for (int i = 0; i < blockCount; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double width = 5 + random.nextDouble() * 25;
      double height = 5 + random.nextDouble() * 25;

      Paint currentPaint = random.nextInt(10) > 8 ? amberPaint : bgPaint;

      canvas.drawRect(Rect.fromLTWH(x, y, width, height), currentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GlitchPaint oldDelegate) {
    return oldDelegate.seed != seed;
  }
}
