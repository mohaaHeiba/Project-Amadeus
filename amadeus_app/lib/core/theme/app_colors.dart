import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // لمنع إنشاء كائن من هذا الكلاس

  // ==========================================
  // 1. Material 3 Color Scheme (من قسم YAML)
  // ==========================================
  static const Color background = Color(0xFF121212);
  static const Color onBackground = Color(0xFFE9E2D4);

  static const Color surface = Color(0xFF16130C);
  static const Color surfaceDim = Color(0xFF16130C);
  static const Color surfaceBright = Color(0xFF3C3930);
  static const Color surfaceContainerLowest = Color(0xFF100E07);
  static const Color surfaceContainerLow = Color(0xFF1E1B13);
  static const Color surfaceContainer = Color(0xFF221F17);
  static const Color surfaceContainerHigh = Color(0xFF2D2A21);
  static const Color surfaceContainerHighest = Color(0xFF38342B);
  static const Color onSurface = Color(0xFFE9E2D4);
  static const Color onSurfaceVariant = Color(0xFFD4C4AF);
  static const Color inverseSurface = Color(0xFFE9E2D4);
  static const Color inverseOnSurface = Color(0xFF333027);

  static const Color outline = Color(0xFF9D8F7C);
  static const Color outlineVariant = Color(0xFF504535);
  static const Color surfaceTint = Color(0xFFFABC4B);

  static const Color primary = Color(0xFFFFC663);
  static const Color onPrimary = Color(0xFF432C00);
  static const Color primaryContainer = Color(0xFFE5A93A); // Warm Golden Amber
  static const Color onPrimaryContainer = Color(0xFF5E4000);
  static const Color inversePrimary = Color(0xFF7E5700);

  static const Color secondary = Color(0xFFFFB4A8);
  static const Color onSecondary = Color(0xFF690000);
  static const Color secondaryContainer = Color(0xFFA50201); // Crimson Red
  static const Color onSecondaryContainer = Color(0xFFFFAEA2);

  static const Color tertiary = Color(0xFFB0D1FF);
  static const Color onTertiary = Color(0xFF00325A);
  static const Color tertiaryContainer = Color(0xFF7AB7FF);
  static const Color onTertiaryContainer = Color(0xFF00477D);

  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);
  static const Color success = Color.fromARGB(255, 105, 240, 174);

  // ==========================================
  // 2. Narrative UI Specifics (من قسم الشرح)
  // ==========================================

  // Base & Canvas (الخلفيات الأساسية)
  static const Color scaffoldBackground = Color(
    0xFF121212,
  ); // Deep Charcoal Base
  static const Color parchmentText = Color(0xFFD9D2C5); // Pale Parchment

  // Elevations & Glassmorphism (الطبقات والزجاج)
  static const Color atmosphericVeil = Color.fromRGBO(
    20,
    20,
    20,
    0.65,
  ); // Level 1
  static const Color dialogPanelBg = Color.fromRGBO(18, 18, 18, 0.72);
  static const Color floatingSurface = Color.fromRGBO(
    28,
    28,
    28,
    0.85,
  ); // Level 2

  // Typographic Ink Opacities (شفافية النصوص)
  static Color textSecondary = const Color(
    0xFFD9D2C5,
  ).withAlpha(153); // 60% opacity
  static Color textTertiary = const Color(
    0xFFD9D2C5,
  ).withAlpha(97); // 38% opacity
  static const Color textPlaceholder = Color.fromRGBO(217, 210, 197, 0.35);
  static const Color chipTextLabel = Color.fromRGBO(217, 210, 197, 0.70);

  // Borders, Dividers & Structural Lines (الحدود والفواصل)
  static const Color borderSubtle = Color.fromRGBO(217, 210, 197, 0.04);
  static const Color dividerLight = Color.fromRGBO(
    217,
    210,
    197,
    0.06,
  ); // للقوائم
  static const Color dividerMedium = Color.fromRGBO(
    217,
    210,
    197,
    0.08,
  ); // حواف الطبقات
  static const Color dividerStrong = Color.fromRGBO(
    217,
    210,
    197,
    0.12,
  ); // حافة لوحة الحوار
  static const Color inputBorder = Color.fromRGBO(217, 210, 197, 0.18);
  static const Color checkboxBorder = Color.fromRGBO(217, 210, 197, 0.25);
  static const Color choiceBorder = Color.fromRGBO(217, 210, 197, 0.10);

  // Actions & Interactions (التفاعلات والأزرار)
  static const Color choiceBackground = Color.fromRGBO(255, 255, 255, 0.03);
  static const Color primaryActionTap = Color.fromRGBO(229, 169, 58, 0.12);
  static const Color primaryActionGlow = Color.fromRGBO(
    229,
    169,
    58,
    0.40,
  ); // توهج الإشعارات
  static const Color criticalActionMuted = Color.fromRGBO(163, 0, 0, 0.12);
  static const Color chipBackground = Color.fromRGBO(217, 210, 197, 0.05);
  static const Color chipActiveBackground = Color.fromRGBO(229, 169, 58, 0.15);
  static const Color inputBackground = Color.fromRGBO(20, 20, 20, 0.50);

  // ==========================================
  // 3. Absolute Colors (ألوان ثابتة مساعدة)
  // ==========================================
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // ==========================================
  // 4. Shadows (الظلال المذكورة في التصميم)
  // ==========================================
  static List<BoxShadow> get criticalOverlayShadow => [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.7),
      offset: Offset(0, 16),
      blurRadius: 40,
      spreadRadius: -8,
    ),
  ];
}
