import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkConnectButton extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;
  final double opacity;
  final VoidCallback? onPressed;

  const NetworkConnectButton({
    required this.networkStatusModel,
    this.opacity = 1,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(color: DesignColors.darkGreen_100),
              )),
            ),
            child: Text(
              'Connect'.toUpperCase(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
