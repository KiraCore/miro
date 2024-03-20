import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class LoadingContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? circularBorderRadius;
  final BoxConstraints? boxConstraints;

  const LoadingContainer({
    this.height,
    this.width,
    this.circularBorderRadius,
    this.boxConstraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: circularBorderRadius != null ? BorderRadius.circular(circularBorderRadius!) : null,
        color: DesignColors.grey2,
      ),
      constraints: boxConstraints,
    );
  }
}
