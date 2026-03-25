import 'package:flutter/material.dart';

class AppStyles {
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white24, Colors.white10],
  );

  static const Color successColor = Color(0xFF00E676);
  static const Color errorColor = Color(0xFFFF5252);

  static BoxDecoration glassDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
    gradient: cardGradient,
  );
}