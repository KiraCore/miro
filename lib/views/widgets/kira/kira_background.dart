import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraBackground extends StatelessWidget {
  final Widget child;

  const KiraBackground({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: DesignColors.background,
      ),
      child: child,
    );
  }
}
