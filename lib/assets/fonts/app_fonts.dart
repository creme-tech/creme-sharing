import 'package:flutter/material.dart';

abstract class AppFonts {
  static TextStyle get bodyBold => const TextStyle(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: -0.02,
      );

  static TextStyle get bodyRegular => const TextStyle(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: -0.02,
      );
}
