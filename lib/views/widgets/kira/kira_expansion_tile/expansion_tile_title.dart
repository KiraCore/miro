import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class ExpansionTileTitle extends StatelessWidget {
  final String title;
  final String? tooltipMessage;

  const ExpansionTileTitle({
    required this.title,
    this.tooltipMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: DesignColors.white_100,
          ),
        ),
        if (tooltipMessage != null) KiraToolTip(message: tooltipMessage!),
      ],
    );
  }
}
