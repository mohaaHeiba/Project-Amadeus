import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AmadeusTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final FocusNode? focusNode;

  const AmadeusTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top label with terminal bracket
        Text(
          '> ${label.toUpperCase()}',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontFamilyFallback: const ['monospace'],
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: hasError ? AppColors.secondary : AppColors.textPlaceholder,
          ),
        ),
        const SizedBox(height: 8),

        // Text field using AppTheme's inputDecorationTheme
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          style: const TextStyle(
            fontFamily: 'JetBrains Mono',
            fontFamilyFallback: ['monospace'],
            fontSize: 14,
            letterSpacing: 1.2,
            color: AppColors.parchmentText,
          ),
          cursorColor: AppColors.primaryContainer,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 18,
                    color: hasError ? AppColors.secondary : AppColors.outline,
                  )
                : null,
            suffixIcon: suffixIcon,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
