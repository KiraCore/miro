import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class PrefixedWidget extends StatelessWidget {
  final String prefix;
  final Widget? child;
  final int? prefixMaxLines;
  final Widget? icon;

  const PrefixedWidget({
    required this.prefix,
    required this.child,
    this.prefixMaxLines,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                prefix,
                maxLines: prefixMaxLines,
                overflow: prefixMaxLines != null ? TextOverflow.ellipsis : null,
                style: (child != null ? textTheme.caption! : textTheme.bodyText2!).copyWith(
                  color: DesignColors.accent,
                ),
              ),
              if (child != null) ...<Widget>[
                const SizedBox(height: 4),
                child!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
