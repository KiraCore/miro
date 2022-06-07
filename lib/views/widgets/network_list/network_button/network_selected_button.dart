import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkSelectedButton extends StatelessWidget {
  final Color color;
  final ANetworkStatusModel networkStatusModel;
  final String title;

  const NetworkSelectedButton({
    required this.color,
    required this.networkStatusModel,
    required this.title,
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
        title.toUpperCase(),
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
