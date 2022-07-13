import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class ListPopMenuHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClearPressed;

  const ListPopMenuHeader({
    required this.title,
    this.onClearPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: DesignColors.white_100,
          fontWeight: FontWeight.w100,
        ),
      ),
      trailing: onClearPressed == null
          ? null
          : IconButton(
              icon: const Text('Clear', style: TextStyle(fontSize: 14, color: DesignColors.gray2_100)),
              onPressed: onClearPressed,
            ),
    );
  }
}
