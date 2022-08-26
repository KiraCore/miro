import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxInputWrapper extends StatelessWidget {
  final Widget child;
  final bool disabled;
  final bool hasErrors;
  final double? height;
  final EdgeInsets padding;

  const TxInputWrapper({
    required this.child,
    this.disabled = false,
    this.hasErrors = false,
    this.height,
    this.padding = const EdgeInsets.all(16),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: DesignColors.gray1_100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasErrors ? DesignColors.red_100 : Colors.transparent,
            width: 1,
          ),
        ),
        child: child,
      ),
    );
  }
}
