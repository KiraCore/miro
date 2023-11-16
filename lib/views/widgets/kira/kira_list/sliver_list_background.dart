import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class SliverListBackground extends StatelessWidget {
  final Widget? child;

  const SliverListBackground({
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: DesignColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
