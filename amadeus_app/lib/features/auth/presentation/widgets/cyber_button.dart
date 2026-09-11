import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CyberButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;
  final double height;

  const CyberButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isSecondary = true,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isSecondary
        ? AppColors.parchmentText
        : AppColors.primaryContainer;

    final bgColor = isSecondary
        ? AppColors.choiceBackground
        : AppColors.primaryContainer.withValues(alpha: 0.12);

    final borderColor = isSecondary
        ? AppColors.outlineVariant
        : AppColors.primaryContainer;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        splashColor: AppColors.primaryActionTap,
        highlightColor: AppColors.primaryActionTap,
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: [
              if (!isSecondary)
                BoxShadow(
                  color: AppColors.primaryActionGlow.withValues(alpha: 0.15),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: primaryColor),
                const SizedBox(width: 10),
              ],
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontFamilyFallback: const ['sans-serif'],
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
