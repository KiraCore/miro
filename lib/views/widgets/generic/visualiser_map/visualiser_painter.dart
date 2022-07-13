import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/visualiser_map/country_model.dart';
import 'package:miro/views/widgets/generic/visualiser_map/size_util.dart';

class VisualiserPainter extends CustomPainter {
  final List<CountryModel> countryModels;

  VisualiserPainter({
    required this.countryModels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    SizeUtil sizeUtil = SizeUtil(size);
    Offset center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.indigo;

    canvas.drawCircle(
      Offset(sizeUtil.getAxisX(center.dx), sizeUtil.getAxisY(center.dy)),
      1,
      paint,
    );
    final Paint countryPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.red;

    Path path = Path()
      ..lineTo(sizeUtil.getAxisX(center.dx - 100), sizeUtil.getAxisY(center.dy - 100))
      ..lineTo(sizeUtil.getAxisX(center.dx - 30), sizeUtil.getAxisY(center.dy + 60))
      ..lineTo(sizeUtil.getAxisX(center.dx - 60), sizeUtil.getAxisY(center.dy + 100));
    canvas.drawPath(path, countryPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
