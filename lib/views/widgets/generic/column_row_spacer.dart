import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive_widget.dart';

class ColumnRowSpacer extends StatelessWidget {
  final double size;

  const ColumnRowSpacer({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: SizedBox(
        width: size,
      ),
      mediumScreen: SizedBox(
        height: size,
      ),
    );
  }
}
