import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class ListPopMenuItem extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback onTap;

  const ListPopMenuItem({
    required this.selected,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      onTap: onTap,
      mouseCursor: SystemMouseCursors.click,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            color: states.contains(MaterialState.hovered) || selected ? DesignColors.greyHover2 : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: <Widget>[
              const SizedBox(height: 24),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyMedium!.copyWith(
                    color: states.contains(MaterialState.hovered) || selected ? DesignColors.white1 : DesignColors.white2,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  AppIcons.done,
                  size: 24,
                  color: DesignColors.white1,
                )
            ],
          ),
        );
      },
    );
  }
}
