import 'package:flutter/material.dart';

class SC {
  // Gradient (splash + all backgrounds)
  static const gradTop = Color(0xFFB4E2FC);
  static const gradMid = Color(0xFFF2EFE6);
  static const gradBot = Color(0xFFE8D5F2);

  // Brand
  static const purple = Color(0xFF8B5BA6);
  static const purpleDark = Color(0xFF5C3578);
  static const purpleLight = Color(0xFFE8D5F2);
  static const lavender = Color(0xFFD9B8FF);
  static const lavLight = Color(0xFFF3EEFF);
  static const btnColor = Color(0xFFD9C7FF);
  static const btnText = Color(0xFF4A2D7A);

  // Sky blue
  static const sky = Color(0xFF8FB8FF);
  static const skyLight = Color(0xFFB4E2FC);
  static const skyDark = Color(0xFF5A8FD4);

  // Mint
  static const mint = Color(0xFF97E3C2);
  static const mintDark = Color(0xFF3A9E74);
  static const mintLight = Color(0xFFE6FAF3);

  // Neutral
  static const bgLight = Color(0xFFF8F4FF);
  static const bgAlt = Color(0xFFF0EBF9);
  static const card = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF2A1A3E);
  static const textMuted = Color(0xFF8A7A9A);
  static const border = Color(0xFFE0D4F0);

  // Status
  static const green = Color(0xFF3A9E74);
  static const red = Color(0xFFD95B5B);
  static const amber = Color(0xFFE8A830);
  static const teal = Color(0xFF00897B);
 
  static Color riskColor(String risk) {
    switch (risk) {
      case 'Low':
        return green;
      case 'High':
        return red;
      default:
        return amber;
    }
  }
}
