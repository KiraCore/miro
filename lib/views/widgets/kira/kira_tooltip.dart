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
    this.textStyle,
    this.waitDuration,
    this.showDuration,
    this.child,
    this.triggerMode = TooltipTriggerMode.tap,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.background,
        border: Border.all(
          color: DesignColors.grey2,
          width: 1,
        ),
      ),
      textStyle: textStyle ??
          textTheme.bodySmall!.copyWith(
            color: DesignColors.white1,
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
              color: DesignColors.accent,
              size: 17,
            ),
      ),
    );
  }
}
