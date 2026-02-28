import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/key_value/detail_value.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class CopyHoverValue extends StatelessWidget {
  const CopyHoverValue({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CopyButton(
          value: value,
          notificationText: S.of(context).toastSuccessfullyCopied,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: KiraToolTip(
            childMargin: EdgeInsets.zero,
            message: value,
            child: DetailValue(value),
          ),
        ),
      ],
    );
  }
}
