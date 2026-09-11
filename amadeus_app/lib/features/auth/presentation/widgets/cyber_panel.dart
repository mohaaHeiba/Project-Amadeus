import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CyberPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double cornerLength;
  final double cornerThickness;
  final Color? cornerColor;

  const CyberPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.cornerLength = 14.0,
    this.cornerThickness = 2.0,
    this.cornerColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveCornerColor = cornerColor ?? AppColors.primaryContainer;

    return CustomPaint(
      foregroundPainter: _CyberCornerPainter(
        cornerLength: cornerLength,
        cornerThickness: cornerThickness,
        cornerColor: effectiveCornerColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dialogPanelBg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.dividerStrong, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: AppColors.primaryActionGlow.withValues(alpha: 0.05),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}

class _CyberCornerPainter extends CustomPainter {
  final double cornerLength;
  final double cornerThickness;
  final Color cornerColor;

  _CyberCornerPainter({
    required this.cornerLength,
    required this.cornerThickness,
    required this.cornerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cornerColor
      ..strokeWidth = cornerThickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    const offset = 0.0;
    final w = size.width;
    final h = size.height;
    final len = cornerLength;

    // Top-Left
    canvas.drawLine(
      const Offset(offset, offset),
      Offset(offset + len, offset),
      paint,
    );
    canvas.drawLine(
      const Offset(offset, offset),
      Offset(offset, offset + len),
      paint,
    );

    // Top-Right
    canvas.drawLine(
      Offset(w - offset, offset),
      Offset(w - offset - len, offset),
      paint,
    );
    canvas.drawLine(
      Offset(w - offset, offset),
      Offset(w - offset, offset + len),
      paint,
    );

    // Bottom-Left
    canvas.drawLine(
      Offset(offset, h - offset),
      Offset(offset + len, h - offset),
      paint,
    );
    canvas.drawLine(
      Offset(offset, h - offset),
      Offset(offset, h - offset - len),
      paint,
    );

    // Bottom-Right
    canvas.drawLine(
      Offset(w - offset, h - offset),
      Offset(w - offset - len, h - offset),
      paint,
    );
    canvas.drawLine(
      Offset(w - offset, h - offset),
      Offset(w - offset, h - offset - len),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CyberCornerPainter oldDelegate) {
    return oldDelegate.cornerLength != cornerLength ||
        oldDelegate.cornerThickness != cornerThickness ||
        oldDelegate.cornerColor != cornerColor;
  }
}
