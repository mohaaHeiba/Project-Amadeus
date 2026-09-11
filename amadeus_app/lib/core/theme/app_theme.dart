import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.scaffoldBackground,

      // ==========================================
      // Color Scheme
      // ==========================================
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        inversePrimary: AppColors.inversePrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        inverseSurface: AppColors.inverseSurface,
        onInverseSurface: AppColors.inverseOnSurface,
      ),

      // ==========================================
      // AppBar Theme
      // ==========================================
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.parchmentText,
        titleTextStyle: TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          color: AppColors.parchmentText,
        ),
      ),

      // ==========================================
      // Typography
      // ==========================================
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 3.0,
          color: AppColors.parchmentText,
        ),
        displayMedium: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 26,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.5,
          color: AppColors.parchmentText,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
          color: AppColors.parchmentText,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: AppColors.parchmentText,
        ),
        titleMedium: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.parchmentText,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 14,
          letterSpacing: 1.0,
          color: AppColors.parchmentText,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: const ['monospace'],
          fontSize: 13,
          letterSpacing: 0.8,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: const ['monospace'],
          fontSize: 11,
          letterSpacing: 0.5,
          color: AppColors.textTertiary,
        ),
        labelLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          color: AppColors.primaryContainer,
        ),
        labelMedium: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 11,
          letterSpacing: 1.2,
          color: AppColors.textPlaceholder,
        ),
        labelSmall: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: const ['monospace'],
          fontSize: 9.5,
          letterSpacing: 1.0,
          color: AppColors.textTertiary,
        ),
      ),

      // ==========================================
      // Input Decoration Theme (Cyber Terminal)
      // ==========================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 13,
          letterSpacing: 1.0,
          color: AppColors.textPlaceholder,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 13,
          letterSpacing: 1.2,
          color: AppColors.textPlaceholder,
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: AppColors.primaryContainer,
        ),
        prefixIconColor: AppColors.outline,
        suffixIconColor: AppColors.outline,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryContainer,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.secondaryContainer,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.secondaryContainer,
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 11,
          color: AppColors.secondary,
          letterSpacing: 0.5,
        ),
      ),

      // ==========================================
      // Button Themes
      // ==========================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimaryContainer,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontFamilyFallback: ['sans-serif'],
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          side: const BorderSide(
            color: AppColors.primaryContainer,
            width: 1.2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontFamilyFallback: ['sans-serif'],
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primaryActionTap;
            }
            return null;
          }),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          textStyle: const TextStyle(
            fontFamily: 'JetBrains Mono',
            fontFamilyFallback: ['monospace'],
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),

      // ==========================================
      // Panel & Card Themes
      // ==========================================
      cardTheme: CardThemeData(
        color: AppColors.dialogPanelBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(
            color: AppColors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.dialogPanelBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(
            color: AppColors.dividerStrong,
            width: 1.0,
          ),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: ['sans-serif'],
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: AppColors.parchmentText,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 13,
          color: AppColors.parchmentText,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(
            color: AppColors.primaryContainer,
            width: 1.0,
          ),
        ),
        contentTextStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontFamilyFallback: ['monospace'],
          fontSize: 12,
          letterSpacing: 1.0,
          color: AppColors.parchmentText,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryContainer;
          }
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(AppColors.onPrimaryContainer),
        side: const BorderSide(
          color: AppColors.checkboxBorder,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.dividerMedium,
        thickness: 1,
      ),
    );
  }
}
