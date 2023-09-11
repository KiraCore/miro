import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraContextMenuItemLayout extends StatelessWidget {
  final String label;
  final IconData iconData;

  const KiraContextMenuItemLayout({
    required this.label,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: DesignColors.white1,
            ),
          ),
        ),
      ],
    );
  }
}
