import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class NetworkConnectedButton extends StatelessWidget {
  final Color color;

  const NetworkConnectedButton({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(
        'Connected'.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          color: _getFontColor(),
        ),
      ),
    );
  }

  Color _getFontColor() {
    final double luminance = color.computeLuminance() * 255;
    Brightness brightness = luminance > 127 ? Brightness.light : Brightness.dark;
    if (brightness == Brightness.light) {
      return DesignColors.gray1_100;
    }
    return DesignColors.white_100;
  }
}
