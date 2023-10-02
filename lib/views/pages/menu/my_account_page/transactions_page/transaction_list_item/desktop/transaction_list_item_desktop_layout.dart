import 'package:flutter/material.dart';

class TransactionListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget txWidget;
  final Widget hashWidget;
  final Widget statusWidget;
  final Widget dateWidget;
  final Widget amountWidget;

  const TransactionListItemDesktopLayout({
    required this.height,
    required this.txWidget,
    required this.hashWidget,
    required this.statusWidget,
    required this.dateWidget,
    required this.amountWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gapSize = 30;
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 40),
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: txWidget,
          ),
          SizedBox(width: gapSize),
          Expanded(
            flex: 4,
            child: hashWidget,
          ),
          SizedBox(width: gapSize),
          SizedBox(
            width: 80,
            child: statusWidget,
          ),
          SizedBox(width: gapSize),
          SizedBox(
            width: 150,
            child: dateWidget,
          ),
          SizedBox(width: gapSize),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: amountWidget,
            ),
          ),
        ],
      ),
    );
  }
}
