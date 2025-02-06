import 'package:flutter/cupertino.dart';

class BlocksListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget ageWidget;
  final Widget hashWidget;
  final Widget heightWidget;
  final Widget kiraToolTipWidget;
  final Widget proposerWidget;
  final Widget txCountWidget;

  const BlocksListItemDesktopLayout({
    required this.height,
    required this.ageWidget,
    required this.hashWidget,
    required this.heightWidget,
    required this.kiraToolTipWidget,
    required this.proposerWidget,
    required this.txCountWidget,
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
          SizedBox(width: 50, child: kiraToolTipWidget),
          Expanded(flex: 1, child: heightWidget),
          Expanded(flex: 2, child: proposerWidget),
          Expanded(flex: 2, child: hashWidget),
          Expanded(child: txCountWidget),
          Expanded(flex: 1, child: ageWidget),
        ],
      ),
    );
  }
}
