import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/views/widgets/generic/network_list/network_button/network_connect_button.dart';
import 'package:miro/views/widgets/generic/network_list/network_button/network_connected_button.dart';

class NetworkButton extends StatelessWidget {
  final Color color;
  final ANetworkStatusModel networkStatusModel;
  final bool isConnected;

  const NetworkButton({
    required this.color,
    required this.networkStatusModel,
    this.isConnected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      return NetworkConnectedButton(color: color);
    }
    if (networkStatusModel is ANetworkOnlineModel) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        color: color,
      );
    }
    if (networkStatusModel is NetworkUnknownModel) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        color: color,
        opacity: 0.3,
        canConnect: false,
      );
    }
    return const Text(
      'Cannot connect to network',
      style: TextStyle(
        color: DesignColors.red_100,
      ),
    );
  }
}
