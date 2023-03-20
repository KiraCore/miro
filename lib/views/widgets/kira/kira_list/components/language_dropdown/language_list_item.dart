import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class LanguageListItem extends StatelessWidget {
  final double height;
  final Widget title;
  final VoidCallback? onTap;

  const LanguageListItem({
    required this.height,
    required this.title,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: _selectBackgroundColor(states)),
          child: title,
        );
      },
    );
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.greyHover2;
    } else {
      return Colors.transparent;
    }
  }
}
