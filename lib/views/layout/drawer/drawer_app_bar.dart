import 'package:flutter/material.dart';
import 'package:miro/views/layout/drawer/drawer_pop_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class DrawerAppBar extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onPop;

  const DrawerAppBar({
    required this.onClose,
    required this.onPop,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets appBarPadding = const EdgeInsets.only(top: 32, left: 20, right: 32, bottom: 32);
    if (ResponsiveWidget.isSmallScreen(context)) {
      appBarPadding = const EdgeInsets.only(top: 37, left: 10, right: 10, bottom: 37);
    }
    return Container(
      padding: appBarPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DrawerPopButton(
            onClose: onClose,
            onPop: onPop,
          ),
        ],
      ),
    );
  }
}
