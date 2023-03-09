import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraCard extends StatelessWidget {
  final Widget child;

  const KiraCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DesignColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
