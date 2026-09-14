import 'package:flutter/material.dart';

/// The three app-wide colors used throughout FindMyTutor.
///
/// Every widget and screen should reference these constants
/// instead of using inline color values.
class AppColors {
  AppColors._();

  /// Primary dark color — used for text, dark card backgrounds, icons.
  static const Color dark = Color(0xFF2C2C2C);

  /// White — used for backgrounds, light text on dark surfaces.
  static const Color white = Color(0xFFFFFFFF);

  /// Teal accent — used for selections, highlights, accents.
  static const Color teal = Color(0xFF009688);
}
