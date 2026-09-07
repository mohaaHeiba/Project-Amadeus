import 'package:flutter/material.dart';

class AppColors {
  // 1. Base & Surfaces
  static const Color background = Color(0xFF16130C);
  static const Color deepCharcoal = Color(0xFF121212);
  static const Color surfaceBright = Color(0xFF3C3930);

  // 2. Primary & Secondary Accents
  static const Color primaryAmber = Color(0xFFE5A93A);
  static const Color secondaryCrimson = Color(0xFFA30000);

  // 3. Text & Ink (Pale Parchment)
  static const Color textPrimary = Color(0xFFD9D2C5);
  static Color textSecondary = const Color(
    0xFFD9D2C5,
  ).withAlpha(153); // 0.60 * 255
  static Color textTertiary = const Color(
    0xFFD9D2C5,
  ).withAlpha(97); // 0.38 * 255

  // 4. Dividers & Ghost Lines
  static Color dividerLight = const Color.fromRGBO(217, 210, 197, 0.08);
  static Color dividerMedium = const Color.fromRGBO(217, 210, 197, 0.14);

  // 5. Atmospheric Layers (Elevations)
  static Color atmosphericVeil = const Color.fromRGBO(20, 20, 20, 0.65);
  static Color floatingSurface = const Color.fromRGBO(28, 28, 28, 0.85);

  // 6. Action States & Highlights
  static Color primaryGhostTap = const Color.fromRGBO(229, 169, 58, 0.12);
  static Color criticalActionFill = const Color.fromRGBO(163, 0, 0, 0.12);
  static Color branchHoverFill = const Color.fromRGBO(255, 255, 255, 0.03);
  static Color chipActiveFill = const Color.fromRGBO(229, 169, 58, 0.15);

  // 7. Inputs & Dialogue Box
  static Color inputBackground = const Color.fromRGBO(20, 20, 20, 0.50);
  static Color inputBorder = const Color.fromRGBO(217, 210, 197, 0.18);
  static Color inputPlaceholder = const Color.fromRGBO(217, 210, 197, 0.35);
  static Color dialoguePanelBg = const Color.fromRGBO(18, 18, 18, 0.72);
}
