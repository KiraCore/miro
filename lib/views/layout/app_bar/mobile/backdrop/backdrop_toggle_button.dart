import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/mobile/backdrop/backdrop_app_bar.dart';

class BackdropToggleButton extends StatelessWidget {
  /// Animated icon that is used for the contained [AnimatedIcon].
  ///
  /// Defaults to [AnimatedIcons.close_menu].
  final AnimatedIconData animatedIconData;

  /// The animated icon's foreground color.
  ///
  /// Defaults to [Colors.white].
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
        progress: Backdrop
            .of(context)
            .animationController
            .view,
      ),
      onPressed: () => Backdrop.of(context).fling(),
    );
  }
}
