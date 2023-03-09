import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxInputPreview extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;
  final bool large;

  const TxInputPreview({
    required this.label,
    required this.value,
    this.icon,
    this.large = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                style: textTheme.caption!.copyWith(
                  color: DesignColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: large ? 22 : 16,
                  fontWeight: large ? FontWeight.w500 : FontWeight.w400,
                  color: DesignColors.white1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
