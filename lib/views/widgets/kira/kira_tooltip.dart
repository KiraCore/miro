import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

/// Duplicate of [Tooltip] widget, to globally setup custom options
class KiraToolTip extends StatelessWidget {
  final EdgeInsetsGeometry childMargin;
  final String message;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? verticalOffset;
  final bool? preferBelow;
  final bool? excludeFromSemantics;
  final Widget? child;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TooltipTriggerMode? triggerMode;

  final bool? enableFeedback;

  const KiraToolTip({
    required this.message,
    this.childMargin = const EdgeInsets.all(8),
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.waitDuration,
    this.showDuration,
    this.child,
    this.triggerMode,
    this.enableFeedback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Tooltip(
      message: message,
      height: height,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration,
      textStyle: textStyle ??
          textTheme.caption!.copyWith(
            color: DesignColors.white_100,
          ),
      waitDuration: waitDuration,
      showDuration: showDuration,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      child: Padding(
        padding: childMargin,
        child: child ??
            const Icon(
              Icons.info_outline,
              color: DesignColors.gray2_100,
              size: 17,
            ),
      ),
    );
  }
}
