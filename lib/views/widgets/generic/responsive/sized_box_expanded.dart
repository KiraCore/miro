import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';

class SizedBoxExpanded extends StatefulWidget {
  final List<ScreenSize> expandOn;
  final List<ScreenSize>? defaultOn;
  final Widget child;
  final double? width;
  final double? height;

  const SizedBoxExpanded({
    required this.expandOn,
    required this.child,
    this.defaultOn,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SizedBoxExpanded();
}

class _SizedBoxExpanded extends State<SizedBoxExpanded> {
  @override
  Widget build(BuildContext context) {
    if (widget.expandOn.contains(ResponsiveWidget.getScreenSize(context))) {
      return Expanded(
        child: widget.child,
      );
    }

    if (widget.defaultOn != null && widget.defaultOn!.contains(ResponsiveWidget.getScreenSize(context))) {
      return widget.child;
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.child,
    );
  }
}
