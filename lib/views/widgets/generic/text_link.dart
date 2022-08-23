import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class TextLink extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final GestureTapCallback? onTap;

  const TextLink({
    required this.text,
    required this.textStyle,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Text(
          text,
          style: textStyle.copyWith(
            color: _selectColor(states),
            decoration: _selectTextDecoration(states),
          ),
        );
      },
    );
  }

  Color _selectColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.blue2_100;
    } else {
      return DesignColors.blue1_100;
    }
  }

  TextDecoration? _selectTextDecoration(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return TextDecoration.underline;
    } else {
      return null;
    }
  }
}
