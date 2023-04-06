import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(_setOverlayColor),
              side: MaterialStateProperty.all(const BorderSide(color: DesignColors.greyOutline)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
            ),
            child: Text(S.of(context).networkButtonConnect.toUpperCase(),
                style: textTheme.button!.copyWith(
                  color: DesignColors.white1,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ],
    );
  }

  Color _setOverlayColor(Set<MaterialState> states) {
    return DesignColors.greyHover1;
  }
}
