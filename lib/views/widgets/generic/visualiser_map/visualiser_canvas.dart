import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/visualiser_map/country_model.dart';
import 'package:miro/views/widgets/generic/visualiser_map/visualiser_painter.dart';

class VisualiserCanvas extends StatefulWidget {
  final List<CountryModel> countryModels;

  const VisualiserCanvas({
    required this.countryModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualiserCanvas();
}

class _VisualiserCanvas extends State<VisualiserCanvas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.yellow,
      child: CustomPaint(painter: VisualiserPainter(countryModels: countryModels)),
    );
  }
}
