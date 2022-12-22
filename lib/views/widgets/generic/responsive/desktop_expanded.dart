import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class DesktopExpanded extends StatelessWidget {
  const DesktopExpanded({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return Expanded(child: child);
    } else {
      return child;
    }
  }
}
