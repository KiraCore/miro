import 'package:flutter/material.dart';

class ProposalListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget idWidget;
  final Widget statusWidget;
  final Widget titleWidget;
  final Widget tooltipWidget;
  final Widget typesWidget;
  final Widget votingEndWidget;

  const ProposalListItemDesktopLayout({
    required this.height,
    required this.idWidget,
    required this.statusWidget,
    required this.titleWidget,
    required this.tooltipWidget,
    required this.typesWidget,
    required this.votingEndWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 100, child: tooltipWidget),
          Expanded(flex: 2, child: votingEndWidget),
          Expanded(flex: 3, child: titleWidget),
          Expanded(flex: 2, child: statusWidget),
          Expanded(flex: 2, child: typesWidget),
          const SizedBox(width: 35),
          SizedBox(width: 65, child: idWidget),
        ],
      ),
    );
  }
}
