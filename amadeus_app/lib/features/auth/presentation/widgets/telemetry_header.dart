import 'package:amadeus_app/core/extensions/spacing.dart';
import 'package:amadeus_app/core/constants/assets.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TelemetryHeader extends StatefulWidget {
  final String statusText;
  final String subtitle;
  final Color statusColor;
  final bool isPulsing;

  const TelemetryHeader({
    super.key,
    required this.statusText,
    required this.statusColor,
    this.isPulsing = true,
    this.subtitle = 'WELCOME 009 TO THE LAB',
  });

  @override
  State<TelemetryHeader> createState() => _TelemetryHeaderState();
}

class _TelemetryHeaderState extends State<TelemetryHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    if (widget.isPulsing) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant TelemetryHeader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPulsing != oldWidget.isPulsing) {
      if (widget.isPulsing) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Live Telemetry bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.choiceBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.dividerMedium, width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final double pulseValue = widget.isPulsing
                      ? _pulseController.value
                      : 1.0;

                  return Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.lerp(
                        Colors.grey.shade600,
                        widget.statusColor,
                        pulseValue,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.statusColor.withValues(
                            alpha: pulseValue * 0.8,
                          ),
                          blurRadius: 8 * pulseValue,
                          spreadRadius: 2 * pulseValue,
                        ),
                      ],
                    ),
                  );
                },
              ),
              8.horizontalSpace,
              Text(
                widget.statusText,
                style: const TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontFamilyFallback: ['monospace'],
                  fontSize: 10,
                  letterSpacing: 1.2,
                  color: AppColors.textPlaceholder,
                ),
              ),
            ],
          ),
        ),
        18.verticalSpace,
        // Amadeus Logo with warm ambient glow
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 140,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryContainer.withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Image.asset(
              Assets.imagesLogo1,
              width: 130,
              height: 55,
              fit: BoxFit.contain,
            ),
          ],
        ),
        12.verticalSpace,

        // Terminal Headline
        const Text(
          'AMADEUS SYSTEM',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontFamilyFallback: ['sans-serif'],
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.5,
            color: AppColors.parchmentText,
          ),
        ),
        4.verticalSpace,
        Text(
          widget.subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'JetBrains Mono',
            fontFamilyFallback: ['monospace'],
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.8,
            color: AppColors.primaryContainer,
          ),
        ),
      ],
    );
  }
}
