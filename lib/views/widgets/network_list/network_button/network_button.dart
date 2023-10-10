import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/views/widgets/network_list/network_button/network_connect_button.dart';
import 'package:miro/views/widgets/network_list/network_button/network_selected_button.dart';

class NetworkButton extends StatelessWidget {
  final bool arrowEnabledBool;
  final ANetworkStatusModel networkStatusModel;
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkButton({
    required this.arrowEnabledBool,
    required this.networkStatusModel,
    this.onConnected,
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
          S.of(context).networkServerOffline,
          style: textTheme.bodySmall!.copyWith(
            color: DesignColors.redStatus1,
          ),
        ),
      );
    } else if (networkConnected) {
      return Row(
        children: <Widget>[
          NetworkSelectedButton(
            networkStatusModel: networkStatusModel,
            title: S.of(context).networkButtonConnected,
            onPressed: _handleConnectToNetworkPressed,
            clickableBool: arrowEnabledBool,
          ),
          if (arrowEnabledBool)
            IconButton(
              icon: const Icon(Icons.arrow_forward_outlined),
              tooltip: S.of(context).networkButtonArrowTip,
              onPressed: _handleConnectToNetworkPressed,
            ),
        ],
      );
    } else if (networkConnecting) {
      return NetworkSelectedButton(
        networkStatusModel: networkStatusModel,
        title: S.of(context).networkButtonConnecting,
        clickableBool: false,
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
        S.of(context).networkErrorCannotConnect,
        style: textTheme.bodySmall!.copyWith(
          color: DesignColors.redStatus1,
        ),
      );
    }
  }

  void _handleConnectToNetworkPressed() {
    ANetworkStatusModel networkStatusModelToConnect = networkStatusModel;
    bool networkConnectedBool = networkStatusModelToConnect.connectionStatusType == ConnectionStatusType.connected;
    if (networkStatusModelToConnect is ANetworkOnlineModel) {
      if (networkConnectedBool == false) {
        globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(networkStatusModelToConnect));
      }
      onConnected?.call(networkStatusModelToConnect);
    }
  }
}
