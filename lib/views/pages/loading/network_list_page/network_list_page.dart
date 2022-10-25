import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/models/network/connection/connection_error_model.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_empty_model.dart';
import 'package:miro/shared/utils/router_utils.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section.dart';
import 'package:miro/views/widgets/network_list/network_list.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

class NetworkListPage extends StatefulWidget {
  final ConnectionErrorType connectionErrorType;
  final ANetworkStatusModel? canceledNetworkStatusModel;
  final RouteMatch<dynamic>? nextRoute;

  const NetworkListPage({
    this.connectionErrorType = ConnectionErrorType.canceledByUser,
    this.canceledNetworkStatusModel,
    this.nextRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionsPage();
}

class _ConnectionsPage extends State<NetworkListPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ConnectionErrorModel? connectionErrorModel = _selectConnectionErrorModel();

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 40,
                height: 42,
                child: Image.asset(
                  Assets.assetsLogoSygnet,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Connection cancelled',
                style: textTheme.headline1!.copyWith(
                  color: DesignColors.white_100,
                ),
              ),
              const SizedBox(height: 4),
              if (connectionErrorModel != null) ...<Widget>[
                Text(
                  connectionErrorModel.message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText2!.copyWith(
                    color: connectionErrorModel.color,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (_isAutoDisconnected == false) ...<Widget>[
                Text(
                  'Select available servers',
                  style: textTheme.bodyText1!.copyWith(
                    color: DesignColors.white_100,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    if (_isAutoDisconnected) ...<Widget>[
                      Text(
                        'Server you are trying to connect:',
                        style: textTheme.bodyText1!.copyWith(color: DesignColors.white_100),
                      ),
                      const SizedBox(height: 10),
                      NetworkListTile(
                        networkStatusModel: widget.canceledNetworkStatusModel!,
                        onConnected: _handleNetworkConnected,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Other available servers:',
                        style: textTheme.bodyText1!.copyWith(color: DesignColors.white_100),
                      ),
                      const SizedBox(height: 10),
                    ],
                    NetworkList(
                      onConnected: _handleNetworkConnected,
                      hiddenNetworkStatusModel: _isAutoDisconnected ? widget.canceledNetworkStatusModel : null,
                    ),
                    NetworkCustomSection(onConnected: _handleNetworkConnected),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ConnectionErrorModel? _selectConnectionErrorModel() {
    switch (widget.connectionErrorType) {
      case ConnectionErrorType.serverOffline:
        return ConnectionErrorModel(
          message: 'Reason: Server is offline',
          color: DesignColors.red_100,
        );
      case ConnectionErrorType.serverUnhealthy:
        return ConnectionErrorModel(
          message: 'Reason: Found problems with server you are trying to connect',
          color: DesignColors.yellow_100,
        );
      default:
        return null;
    }
  }

  bool get _isAutoDisconnected {
    return widget.canceledNetworkStatusModel != null && widget.canceledNetworkStatusModel is! NetworkEmptyModel;
  }

  void _handleNetworkConnected(ANetworkStatusModel networkStatusModel) {
    PageRouteInfo<dynamic> nextRoute = RouterUtils.getNextRouteAfterLoading(widget.nextRoute);
    AutoRouter.of(context).navigate(nextRoute);
  }
}
