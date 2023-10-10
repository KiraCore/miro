import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class AccountMenuListTile extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  const AccountMenuListTile({
    required this.title,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        Color color = _selectColor(states);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: _selectBackgroundColor(states)),
          child: Text(
            title,
            style: textTheme.bodyMedium!.copyWith(
              color: onTap != null ? color : color.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }

  Color _selectColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.white1;
    } else if (color != null) {
      return color!;
    } else {
      return DesignColors.white2;
    }
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.greyHover2;
    } else {
      return Colors.transparent;
    }
  }
}
