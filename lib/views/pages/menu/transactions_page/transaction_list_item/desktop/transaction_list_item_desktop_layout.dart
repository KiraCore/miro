import 'package:flutter/cupertino.dart';

class TransactionListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget hashWidget;
  final Widget methodWidget;
  final Widget dateWidget;
  final bool isDateInAgeFormatBool;
  final Widget fromWidget;
  final Widget toWidget;
  final Widget amountWidget;
  final Widget feeWidget;

  const TransactionListItemDesktopLayout({
    required this.height,
    required this.hashWidget,
    required this.methodWidget,
    required this.dateWidget,
    required this.fromWidget,
    required this.toWidget,
    required this.amountWidget,
    required this.feeWidget,
    this.isDateInAgeFormatBool = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gapSize = 30;
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 40),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: hashWidget,
          ),
          SizedBox(width: gapSize),
          Expanded(
            flex: 3,
            child: methodWidget,
          ),
          SizedBox(width: gapSize),
          SizedBox(
            width: isDateInAgeFormatBool ? 55 : 120,
            child: dateWidget,
          ),
          SizedBox(width: gapSize),
          Expanded(
            flex: 4,
            child: fromWidget,
          ),
          SizedBox(width: gapSize),
          Expanded(
            flex: 4,
            child: toWidget,
          ),
          SizedBox(width: gapSize),
          SizedBox(
            width: 80,
            child: Align(alignment: Alignment.centerRight, child: amountWidget),
          ),
          SizedBox(width: gapSize),
          SizedBox(
            width: 80,
            child: Align(alignment: Alignment.centerRight, child: feeWidget),
          ),
        ],
      ),
    );
  }
}
