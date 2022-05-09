import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class RoundedIcon extends StatelessWidget {
  final Icon icon;
  final double size;

  const RoundedIcon({
    required this.icon,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: DesignColors.blue1_20,
        radius: size / 2,
        child: Center(
          child: Icon(
            icon.icon,
            size: icon.size,
            color: DesignColors.gray2_100,
          ),
        ),
      ),
    );
  }
}
