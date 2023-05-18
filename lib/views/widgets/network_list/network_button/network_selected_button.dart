import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkSelectedButton extends StatelessWidget {
  final bool clickableBool;
  final String title;
  final ANetworkStatusModel networkStatusModel;
  final VoidCallback? onPressed;

  const NetworkSelectedButton({
    required this.clickableBool,
    required this.title,
    required this.networkStatusModel,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: clickableBool ? onPressed : null,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(networkStatusModel.statusColor)),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _adjustFontColor(),
              letterSpacing: 0.18,
            ),
          ),
        ),
      ],
    );
  }

  Color _adjustFontColor() {
    final double luminance = networkStatusModel.statusColor.computeLuminance() * 255;
    Brightness brightness = luminance > 127 ? Brightness.light : Brightness.dark;
    if (brightness == Brightness.light) {
      return DesignColors.background;
    }
    return DesignColors.white1;
  }
}
