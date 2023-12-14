import 'package:flutter/material.dart';

class UndelegationListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget validatorWidget;
  final Widget tokensWidget;
  final Widget lockedUntilWidget;

  const UndelegationListItemDesktopLayout({
    required this.height,
    required this.validatorWidget,
    required this.tokensWidget,
    required this.lockedUntilWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 25),
          Expanded(flex: 2, child: validatorWidget),
          Expanded(child: tokensWidget),
          Expanded(child: lockedUntilWidget),
          const SizedBox(width: 25),
        ],
      ),
    );
  }
}
