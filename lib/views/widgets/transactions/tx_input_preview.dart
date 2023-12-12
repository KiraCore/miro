import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/expandable_text.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TxInputPreview extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;
  final bool large;
  final Color labelColor;

  const TxInputPreview({
    required this.label,
    required this.value,
    this.icon,
    this.large = false,
    this.labelColor = DesignColors.accent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? textStyle = ResponsiveWidget.isLargeScreen(context) ? textTheme.bodyLarge : textTheme.bodyMedium;

    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          SizedBox(width: 45, height: 45, child: icon),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: textTheme.bodySmall!.copyWith(
                  color: labelColor,
                ),
              ),
              SizedBox(height: const ResponsiveValue<double>(largeScreen: 5, mediumScreen: 2, smallScreen: 2).get(context)),
              ExpandableText(
                initialTextLength: const ResponsiveValue<int>(
                  largeScreen: 500,
                  mediumScreen: 300,
                  smallScreen: 150,
                ).get(context),
                textLengthSeeMore: 500,
                text: Text(
                  value,
                  style: textStyle?.copyWith(
                    fontSize: large ? 22 : null,
                    fontWeight: large ? FontWeight.w500 : null,
                    color: DesignColors.white1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
