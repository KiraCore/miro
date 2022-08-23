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
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(
        title,
        style: textTheme.bodyText2!.copyWith(
          color: DesignColors.white_100,
        ),
      ),
      trailing: onClearPressed == null
          ? null
          : IconButton(
              icon: Text(
                'Clear',
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.gray2_100,
                ),
              ),
              onPressed: onClearPressed,
            ),
    );
  }
}
