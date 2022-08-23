import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/widgets/network_list/network_button/network_button.dart';
import 'package:miro/views/widgets/network_list/network_list_tile_content.dart';
import 'package:miro/views/widgets/network_list/network_list_tile_title.dart';

class NetworkListTile extends StatefulWidget {
  final ANetworkStatusModel networkStatusModel;

  const NetworkListTile({
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkListTile();
}

class _NetworkListTile extends State<NetworkListTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      builder: (BuildContext buildContext, NetworkModuleState networkModuleState) {
        ANetworkStatusModel networkStatusModel = widget.networkStatusModel;
        if (networkStatusModel.uri == networkModuleState.networkStatusModel.uri) {
          networkStatusModel = networkModuleState.networkStatusModel;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: _selectBorderColor(networkStatusModel),
            ),
            color: _selectBackgroundColor(networkStatusModel),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Wrap(
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: NetworkListTileTitle(networkStatusModel: networkStatusModel),
                  collapsedIconColor: Colors.white,
                  children: <Widget>[NetworkListTileContent(networkStatusModel: networkStatusModel)],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  const SizedBox(width: 35),
                  Expanded(child: NetworkButton(networkStatusModel: networkStatusModel)),
                  const SizedBox(width: 35),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Color _selectBorderColor(ANetworkStatusModel networkStatusModel) {
    switch (networkStatusModel.connectionStatusType) {
      case ConnectionStatusType.connected:
        return networkStatusModel.statusColor;
      default:
        return const Color(0xFF4E4C71);
    }
  }

  Color _selectBackgroundColor(ANetworkStatusModel networkStatusModel) {
    switch (networkStatusModel.connectionStatusType) {
      case ConnectionStatusType.disconnected:
        return Colors.transparent;
      default:
        return networkStatusModel.statusColor.withOpacity(0.1);
    }
  }
}
