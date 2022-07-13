import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class PrefixedWidget extends StatelessWidget {
  final String prefix;
  final Widget child;
  final Widget? icon;

  const PrefixedWidget({
    required this.prefix,
    required this.child,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
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
          ),
        ),
      ],
    );
  }
}
