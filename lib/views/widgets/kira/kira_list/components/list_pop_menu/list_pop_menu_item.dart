import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class ListPopMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool selected;

  const ListPopMenuItem({
    required this.onTap,
    required this.title,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      dense: true,
      title: Text(
        title,
        style: textTheme.bodyText2!.copyWith(
          color: DesignColors.gray2_100,
        ),
      ),
      trailing: selected
          ? const Icon(
              AppIcons.done,
              color: DesignColors.blue1_100,
              size: 18,
            )
          : null,
    );
  }
}
