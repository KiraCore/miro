import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class FooterIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const FooterIconButton({
    required this.iconData,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      color: DesignColors.gray2_100,
      splashRadius: 20,
      iconSize: 20,
    );
  }
}
