import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class IRRecordTileDesktopLayout extends StatelessWidget {
  final bool infoButtonVisibleBool;
  final Widget infoButtonWidget;
  final Widget buttonWidget;
  final Widget recordWidget;
  final Widget statusWidget;
  final double height;

  const IRRecordTileDesktopLayout({
    required this.infoButtonVisibleBool,
    required this.infoButtonWidget,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (infoButtonVisibleBool) ...<Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Center(child: infoButtonWidget),
            ),
            const SizedBox(width: 25),
          ],
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              constraints: BoxConstraints(minHeight: height),
              child: Align(alignment: Alignment.centerLeft, child: recordWidget),
            ),
          ),
          const Spacer(flex: 1),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 20),
            constraints: BoxConstraints(minHeight: height),
            child: Align(alignment: Alignment.centerLeft, child: statusWidget),
          ),
          const Spacer(flex: 1),
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(vertical: 20),
            constraints: BoxConstraints(minHeight: height),
            child: Align(alignment: Alignment.centerRight, child: buttonWidget),
          ),
        ],
      ),
    );
  }
}
