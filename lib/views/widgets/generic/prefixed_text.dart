import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class PrefixedWidget extends StatelessWidget {
  final String prefix;
  final Widget child;

  const PrefixedWidget({
    required this.prefix,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          prefix,
          style: const TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
