import 'package:flutter/cupertino.dart';

class BlocksListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget ageWidget;
  final Widget hashWidget;
  final Widget heightWidget;
  final Widget proposerWidget;
  final Widget txCountWidget;
  final bool isDateInAgeFormatBool;

  const BlocksListItemDesktopLayout({
    required this.height,
    required this.ageWidget,
    required this.hashWidget,
    required this.heightWidget,
    required this.proposerWidget,
    required this.txCountWidget,
    required this.isDateInAgeFormatBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gapSize = 30;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: gapSize),
          Expanded(flex: 1, child: heightWidget),
          SizedBox(width: gapSize),
          Expanded(flex: 2, child: proposerWidget),
          SizedBox(width: gapSize),
          Expanded(flex: 2, child: hashWidget),
          SizedBox(width: gapSize),
          Expanded(child: txCountWidget),
          SizedBox(width: gapSize),
          // TODO isDateInAgeFormatBool
          Expanded(flex: 1, child: ageWidget),
          SizedBox(width: gapSize),
        ],
      ),
    );
  }
}
