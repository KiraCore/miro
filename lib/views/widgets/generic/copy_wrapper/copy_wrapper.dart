import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class CopyWrapper extends StatelessWidget {
  final String value;
  final Widget child;
  final String? notificationText;

  const CopyWrapper({
    required this.value,
    required this.child,
    this.notificationText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveValue<Widget>(
      largeScreen: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: <Widget>[
          child,
          const SizedBox(width: 8),
          CopyButton(
            value: value,
            notificationText: notificationText,
          ),
        ],
      ),
      smallScreen: Row(
        children: <Widget>[
          Expanded(
            child: child,
          ),
          const SizedBox(width: 8),
          CopyButton(
            value: value,
            notificationText: notificationText,
          ),
        ],
      ),
    ).get(context);
  }
}
