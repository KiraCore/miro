import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualiserPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..isAntiAlias = true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
