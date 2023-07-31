import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class IRRecordTileDesktopLayout extends StatelessWidget {
  final Widget buttonWidget;
  final Widget recordWidget;
  final Widget statusWidget;
  final double height;

  const IRRecordTileDesktopLayout({
    required this.buttonWidget,
    required this.recordWidget,
    required this.statusWidget,
    this.height = 85,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DesignColors.grey2,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              constraints: BoxConstraints(minHeight: height),
              child: Align(alignment: Alignment.centerLeft, child: recordWidget),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              constraints: BoxConstraints(minHeight: height),
              child: Align(alignment: Alignment.centerLeft, child: statusWidget),
            ),
          ),
        ],
      ),
    );
  }
}
