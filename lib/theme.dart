import 'package:flutter/material.dart';

/// Warna mengikuti identitas kampus: biru tua dan kuning emas.
class AppColors {
  static const navy = Color(0xFF14264B);
  static const gold = Color(0xFFF2B705);
  static const paper = Color(0xFFF3F5F9);
  static const ink = Color(0xFF111A2E);
  static const muted = Color(0xFF5B6679);
  static const line = Color(0xFFD5DBE7);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      primary: AppColors.navy,
      secondary: AppColors.gold,
    ),
    scaffoldBackgroundColor: AppColors.paper,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
  );
}
