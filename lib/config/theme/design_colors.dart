import 'package:flutter/material.dart';

class DesignColors {
  static const Color red = Color(0xFFFD5F5F);
  static const Color green = Color(0xFF23E73C);
  static const Color darkGreen = Color(0xFF35AE83);
  static const Color yellow = Color(0xFFF2E46C);
  static const Color pink = Color(0xFFD429FF);

  static const Color blue1_100 = Color(0xFF298DFF);
  static const Color blue1_20 = Color(0x33298DFF);
  static const Color blue1_10 = Color(0x1A298DFF);

  static const Color blue2_100 = Color(0xFF4264F2);
  static const Color blue2_10 = Color(0x1A4264F2);

  static const Color blue3_100 = Color(0xFF344AE6);
  static const Color blue3_10 = Color(0x1A344AE6);

  static const Color gray1_100 = Color(0xFF060817);

  static const Color gray2_100 = Color(0xFF6489B4);
  static const Color gray2_40 = Color(0x666489B4);

  static const Color gray3_100 = Color(0xFFCFEBFF);
  static const Color gray3_5 = Color(0x0DCFEBFF);

  static const Color white_100 = Color(0xFFFFFFFF);
  static const Color white_50 = Color(0x80FFFFFF);
  static const Color white_20 = Color(0x1AFFFFFF);
  static const Color white_5 = Color(0x0DFFFFFF);

  static const Gradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      Color(0xFF298DFF),
      Color(0xFF344AE6),
    ],
  );

  static const Gradient primaryButtonGradientHover = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      Color(0xFF344AE6),
      Color(0xFF298DFF),
    ],
  );
}
