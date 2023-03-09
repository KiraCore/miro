import 'package:flutter/material.dart';

class DesignColors {
  static const Color accent = Color(0xFF83cf8c);

  static const Color white1 = Color(0xFFf7f7f7);
  static const Color white2 = Color(0xFFcccccc);

  static const Color grey1 = Color(0xFF999999);
  static const Color grey2 = Color(0xFF404040);
  static const Color grey3 = Color(0xFF2f2f2f);
  static const Color greyHover1 = Color(0xFF2f2f2f);
  static const Color greyHover2 = Color(0xFF212121);
  static const Color greyOutline = Color(0xFF595959);
  static const Color greyTransparent = Color(0x801c1c1c);

  static const Color background = Color(0xFF1d1f1d);
  static const Color black = Color(0xFF161816);

  static const Color redStatus1 = Color(0xFFff5454);
  static const Color redStatus2 = Color(0xFF3a3234);
  static const Color redStatus3 = Color(0xFF2E2222);

  static const Color yellowStatus1 = Color(0xFFF2e46c);
  static const Color yellowStatus2 = Color(0xFF3d3d33);

  static const Color greenStatus1 = Color(0xFF76cf80);
  static const Color greenStatus2 = Color(0xFF2E3D2D);

  static const Color pink = Color(0xFFf549e7);
  static const Color orange = Color(0xFFf4a040);
  static const Color turquoise = Color(0xFF31d2d2);

  static const Color avatar = Color(0xFF303430);

  static const Gradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      white2,
      white1,
      white2,
    ],
  );

  static const Gradient primaryButtonGradientHover = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      white1,
      white2,
      white1,
    ],
  );
}
