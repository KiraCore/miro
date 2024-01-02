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
          tooltipWidget,
          SizedBox(
            width: 50,
            height: 50,
            child: Center(child: idWidget),
          ),
          Expanded(flex: 4, child: titleWidget),
          Expanded(flex: 2, child: statusWidget),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: typesWidget),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: votingEndWidget),
        ],
      ),
    );
  }
}
