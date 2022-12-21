import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class DrawerTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? tooltipMessage;

  const DrawerTitle({
    required this.title,
    this.subtitle,
    this.tooltipMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: textTheme.headline3!.copyWith(
                color: DesignColors.white_100,
              ),
            ),
            if (subtitle == null && tooltipMessage != null) KiraToolTip(message: tooltipMessage!),
          ],
        ),
        if (subtitle != null)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                subtitle!,
                style: textTheme.bodyText1!.copyWith(
                  color: DesignColors.gray2_100,
                ),
              ),
              if (tooltipMessage != null) KiraToolTip(message: tooltipMessage!)
            ],
          ),
      ],
    );
  }
}
