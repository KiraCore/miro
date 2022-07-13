import 'dart:math';
import 'dart:ui';

class SizeUtil {
  static const int designWidth = 90;
  static const int designHeight = 180;

  //logic size in device
  final Size logicSize;

  SizeUtil(this.logicSize);

  //device pixel radio.

  double get width {
    return logicSize.width;
  }

  double get height {
    return logicSize.height;
  }

  //@param w is the design w;
  double getAxisX(double w) {
    return (w * width) / designWidth;
  }

// the y direction
  double getAxisY(double h) {
    return (h * height) / designHeight;
  }

  // diagonal direction value with design size s.
  double getAxisBoth(double s) {
    return s * sqrt((width * width + height * height) / (designWidth * designWidth + designHeight * designHeight));
  }
}
