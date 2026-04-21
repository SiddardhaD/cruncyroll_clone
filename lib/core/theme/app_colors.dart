import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryOrange = Color(0xFFF47521);
  static const Color primaryDark = Color(0xFF23252B);
  static const Color secondaryDark = Color(0xFF1A1A1D);
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color cardDark = Color(0xFF1E1E1E);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF6E6E6E);
  
  static const Color accentBlue = Color(0xFF4A9EFF);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentRed = Color(0xFFFF5252);
  static const Color accentYellow = Color(0xFFFFC107);
  
  static const Color divider = Color(0xFF2A2A2A);
  static const Color border = Color(0xFF3A3A3A);
  
  static const Color shimmerBase = Color(0xFF2A2A2A);
  static const Color shimmerHighlight = Color(0xFF3A3A3A);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  
  static const Color overlay = Color(0x99000000);
  static const Color scrim = Color(0xCC000000);
  
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primaryOrange, Color(0xFFFF8C42)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  
  static LinearGradient get darkGradient => const LinearGradient(
        colors: [primaryDark, backgroundDark],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  
  static LinearGradient get overlayGradient => LinearGradient(
        colors: [
          Colors.transparent,
          backgroundDark.withValues(alpha: 0.8),
          backgroundDark,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.6, 1.0],
      );
}
