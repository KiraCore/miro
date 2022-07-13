import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class BalanceListItemLayout extends StatelessWidget {
  final ValueNotifier<bool> expandNotifier;
  final ValueNotifier<bool> hoverNotifier;
  final Widget itemContent;

  const BalanceListItemLayout({
    required this.expandNotifier,
    required this.hoverNotifier,
    required this.itemContent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: expandNotifier,
      builder: (_, bool expanded, __) => _buildItemLayout(expanded),
    );
  }

  Widget _buildItemLayout(bool expanded) {
    return MouseStateListener(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {},
      onHover: (bool value) => hoverNotifier.value = value,
      disableSplash: true,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            color: _selectBackgroundColor(states, expanded),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: expanded ? DesignColors.blue1_100 : Colors.transparent,
              width: 1,
            ),
          ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: itemContent,
          ),
        );
      },
    );
  }

  Color _selectBackgroundColor(Set<MaterialState> states, bool expanded) {
    if (expanded || states.contains(MaterialState.hovered)) {
      return DesignColors.blue1_10;
    }
    return Colors.transparent;
  }
}
