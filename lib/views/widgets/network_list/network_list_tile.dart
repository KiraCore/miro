import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
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
              color: getBorderColor(networkStatusModel),
            ),
            color: getBackgroundColor(networkStatusModel),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Wrap(
            children: <Widget>[
              Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: NetworkListTileTitle(
                    networkStatusModel: networkStatusModel,
                    foregroundColor: getForegroundColor(networkStatusModel),
                  ),
                  collapsedIconColor: Colors.white,
                  children: <Widget>[NetworkListTileContent(networkStatusModel: networkStatusModel)],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  const SizedBox(width: 35),
                  NetworkButton(
                    networkStatusModel: networkStatusModel,
                    color: getForegroundColor(networkStatusModel),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Color getBorderColor(ANetworkStatusModel networkStatusModel) {
    switch (networkStatusModel.connectionStatusType) {
      case ConnectionStatusType.connected:
        return getForegroundColor(networkStatusModel);
      default:
        return const Color(0xFF4E4C71);
    }
  }

  Color getBackgroundColor(ANetworkStatusModel networkStatusModel) {
    switch (networkStatusModel.connectionStatusType) {
      case ConnectionStatusType.connected:
        return getForegroundColor(networkStatusModel).withOpacity(0.1);
      case ConnectionStatusType.connecting:
        return Colors.grey.withOpacity(0.1);
      default:
        return Colors.transparent;
    }
  }

  Color getForegroundColor(ANetworkStatusModel networkStatusModel) {
    switch (networkStatusModel.runtimeType) {
      case NetworkHealthyModel:
        return DesignColors.darkGreen_100;
      case NetworkUnhealthyModel:
        return DesignColors.yellow_100;
      case NetworkUnknownModel:
        return Colors.grey;
      default:
        return DesignColors.red_100;
    }
  }
}
