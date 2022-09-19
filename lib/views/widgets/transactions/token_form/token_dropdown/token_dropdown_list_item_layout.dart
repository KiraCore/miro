import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class TokenDropdownListItemLayout extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final bool selected;
  final Widget subtitle;
  final Widget title;

  const TokenDropdownListItemLayout({
    required this.icon,
    required this.onTap,
    required this.selected,
    required this.subtitle,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> materialStates) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: _selectColor(materialStates),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 30,
                height: 30,
                child: icon,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    title,
                    subtitle,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (selected)
                const Icon(
                  AppIcons.done,
                  size: 24,
                  color: DesignColors.blue1_100,
                )
              else
                const SizedBox(width: 24, height: 24),
            ],
          ),
        );
      },
    );
  }

  Color _selectColor(Set<MaterialState> materialStates) {
    bool isHovered = materialStates.contains(MaterialState.hovered);
    if (isHovered || selected) {
      return DesignColors.blue1_10;
    } else {
      return Colors.transparent;
    }
  }
}
