import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network/network_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkConnectButton extends StatelessWidget {
  final Color color;
  final ANetworkStatusModel networkStatusModel;
  final bool canConnect;
  final double opacity;

  const NetworkConnectButton({
    required this.color,
    required this.networkStatusModel,
    this.canConnect = true,
    this.opacity = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: OutlinedButton(
        onPressed: canConnect ? _connectToNetwork : null,
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
    );
  }

  Future<void> _connectToNetwork() async {
    if (networkStatusModel is ANetworkOnlineModel) {
      globalLocator<NetworkBloc>().add(NetworkSetUpEvent(networkStatusModel as ANetworkOnlineModel));
    }
  }
}
