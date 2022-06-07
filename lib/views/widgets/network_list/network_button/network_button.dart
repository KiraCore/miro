import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/views/widgets/network_list/network_button/network_connect_button.dart';
import 'package:miro/views/widgets/network_list/network_button/network_selected_button.dart';

class NetworkButton extends StatelessWidget {
  final Color color;
  final ANetworkStatusModel networkStatusModel;

  const NetworkButton({
    required this.color,
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (networkStatusModel.connectionStatusType == ConnectionStatusType.connected) {
      return NetworkSelectedButton(
        networkStatusModel: networkStatusModel,
        color: color,
        title: 'Connected',
      );
    }
    if (networkStatusModel.connectionStatusType == ConnectionStatusType.connecting) {
      return NetworkSelectedButton(
        networkStatusModel: networkStatusModel,
        color: color,
        title: 'Connecting...',
      );
    }
    if (networkStatusModel is ANetworkOnlineModel) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        color: color,
        onPressed: _handleConnectToNetworkPressed,
      );
    }
    if (networkStatusModel is NetworkUnknownModel) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        color: color,
        opacity: 0.6,
        onPressed: null,
      );
    }
    return const Text(
      'Cannot connect to network',
      style: TextStyle(
        color: DesignColors.red_100,
      ),
    );
  }

  void _handleConnectToNetworkPressed() {
    ANetworkStatusModel networkStatusModelToConnect = networkStatusModel;
    if (networkStatusModelToConnect is ANetworkOnlineModel) {
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(networkStatusModelToConnect));
    }
  }
}
