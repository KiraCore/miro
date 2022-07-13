import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/visualiser_map/country_model.dart';

class VisualiserPainter extends CustomPainter {
  final List<CountryModel> countryModels;

  VisualiserPainter({
    required this.countryModels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.indigo;

    canvas.drawCircle(
      const Rect.fromCenter(center: Offset(0, 0), width: 20, height: 20),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
