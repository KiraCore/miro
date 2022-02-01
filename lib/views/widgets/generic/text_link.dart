import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class TextLink extends StatelessWidget {
  final String text;
  final double? fontSize;
  final GestureTapCallback? onTap;

  const TextLink(
    this.text, {
    this.fontSize,
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
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: states.contains(MaterialState.pressed) ? DesignColors.blue2_100 : DesignColors.blue1_100,
            decoration: states.contains(MaterialState.hovered) && !states.contains(MaterialState.pressed)
                ? TextDecoration.underline
                : null,
          ),
        );
      },
    );
  }
}
