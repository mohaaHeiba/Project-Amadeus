import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isError ? Colors.redAccent : const Color(0xFFE5A93A),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        content: Row(
          children: [
            Icon(
              isError ? Icons.warning_amber_rounded : Icons.terminal_rounded,
              color: isError ? Colors.redAccent : const Color(0xFFE5A93A),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontFamilyFallback: ['monospace'],
                  fontSize: 12,
                  color: AppColors.parchmentText,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
