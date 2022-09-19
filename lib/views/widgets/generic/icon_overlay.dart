import 'package:flutter/material.dart';

class IconOverlay extends StatelessWidget {
  final Widget child;
  final Widget? icon;

  const IconOverlay({
    required this.child,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Center(
            child: child,
          ),
        ),
        if (icon != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: icon!,
          ),
      ],
    );
  }
}
