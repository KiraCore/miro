import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';

class BackdropMenuButton extends StatelessWidget {
  final AnimatedIconData animatedIconData;
  final Color color;

  const BackdropMenuButton({
    this.animatedIconData = AnimatedIcons.close_menu,
    this.color = DesignColors.white1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: animatedIconData,
        color: color,
        progress: Backdrop.of(context).animationController.view,
      ),
      onPressed: Backdrop.of(context).invertVisibility,
    );
  }
}
