import 'package:flutter/material.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';

class BackdropToggleButton extends StatelessWidget {
  final AnimatedIconData animatedIconData;
  final Color color;

  const BackdropToggleButton({
    this.animatedIconData = AnimatedIcons.close_menu,
    this.color = Colors.white,
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
      onPressed: Backdrop.of(context).toggle,
    );
  }
}
