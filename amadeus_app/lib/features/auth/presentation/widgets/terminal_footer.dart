import 'package:amadeus_app/core/extensions/spacing.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TerminalFooter extends StatelessWidget {
  const TerminalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_clock_outlined,
              size: 12,
              color: AppColors.outlineVariant,
            ),
            6.horizontalSpace,
            Text(
              'SHA-256 ENCRYPTED • FUTURE GADGET LAB',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontFamilyFallback: const ['monospace'],
                fontSize: 9,
                letterSpacing: 1.2,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        4.verticalSpace,
        const Text(
          'WORLDLINE: 1.048596% • CLEARANCE STRICTLY ENFORCED',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontFamilyFallback: ['monospace'],
            fontSize: 9,
            letterSpacing: 1.2,
            color: AppColors.textPlaceholder,
          ),
        ),
      ],
    );
  }
}
