import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/views/widgets/network_list/network_button/network_connect_button.dart';
import 'package:miro/views/widgets/network_list/network_button/network_selected_button.dart';

class NetworkButton extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;

  const NetworkButton({
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool networkConnected = networkStatusModel.connectionStatusType == ConnectionStatusType.connected;
    bool networkConnecting = networkStatusModel.connectionStatusType == ConnectionStatusType.connecting;
    bool networkOnline = networkStatusModel is ANetworkOnlineModel;
    bool networkUnknown = networkStatusModel is NetworkUnknownModel;
    bool networkOffline = networkStatusModel is NetworkOfflineModel;

    if (networkConnected && networkOffline) {
      return SizedBox(
        width: double.infinity,
        child: Text(
          'Selected server is offline\nPlease choose different network',
          style: textTheme.caption!.copyWith(
            color: DesignColors.red_100,
          ),
        ),
      );
    } else if (networkConnected) {
      return NetworkSelectedButton(
        networkStatusModel: networkStatusModel,
        title: 'Connected',
      );
    } else if (networkConnecting) {
      return NetworkSelectedButton(
        networkStatusModel: networkStatusModel,
        title: 'Connecting...',
      );
    } else if (networkOnline) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        onPressed: _handleConnectToNetworkPressed,
      );
    } else if (networkUnknown) {
      return NetworkConnectButton(
        networkStatusModel: networkStatusModel,
        opacity: 0.6,
        onPressed: null,
      );
    } else {
      return Text(
        'Cannot connect to network',
        style: textTheme.caption!.copyWith(
          color: DesignColors.red_100,
        ),
      );
    }
  }

  void _handleConnectToNetworkPressed() {
    ANetworkStatusModel networkStatusModelToConnect = networkStatusModel;
    if (networkStatusModelToConnect is ANetworkOnlineModel) {
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(networkStatusModelToConnect));
    }
  }
}
