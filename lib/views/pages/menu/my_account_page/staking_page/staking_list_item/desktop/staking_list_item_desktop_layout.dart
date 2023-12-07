import 'package:flutter/cupertino.dart';

class StakingListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget infoButtonWidget;
  final Widget validatorWidget;
  final Widget statusWidget;
  final Widget tokensWidget;
  final Widget commissionWidget;
  final Widget actionsWidget;

  const StakingListItemDesktopLayout({
    required this.height,
    required this.infoButtonWidget,
    required this.validatorWidget,
    required this.statusWidget,
    required this.tokensWidget,
    required this.commissionWidget,
    required this.actionsWidget,
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
          SizedBox(width: 100, child: infoButtonWidget),
          Expanded(flex: 6, child: validatorWidget),
          const SizedBox(width: 8),
          Expanded(flex: 3, child: statusWidget),
          const SizedBox(width: 8),
          Expanded(flex: 4, child: tokensWidget),
          const SizedBox(width: 8),
          Expanded(flex: 3, child: commissionWidget),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: actionsWidget),
        ],
      ),
    );
  }
}
