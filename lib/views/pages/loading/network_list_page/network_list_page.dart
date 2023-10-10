import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/connection/connection_error_model.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_empty_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/utils/router_utils.dart';
import 'package:miro/views/pages/loading/network_list_page/network_headline.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section.dart';
import 'package:miro/views/widgets/network_list/network_list.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

@RoutePage()
class NetworkListPage extends StatefulWidget {
  final ConnectionErrorType connectionErrorType;
  final ANetworkStatusModel? canceledNetworkStatusModel;
  final PageRouteInfo? nextPageRouteInfo;

  const NetworkListPage({
    this.connectionErrorType = ConnectionErrorType.canceledByUser,
    this.canceledNetworkStatusModel,
    this.nextPageRouteInfo,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkListPage();
}

class _NetworkListPage extends State<NetworkListPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ConnectionErrorModel? connectionErrorModel = _selectConnectionErrorModel();
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: AppSizes.defaultMobilePageMargin.copyWith(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 40,
                height: 42,
                child: Image.asset(
                  Assets.assetsLogoSignet,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              NetworkHeadline(
                textStyle: textTheme.displayLarge!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
              const SizedBox(height: 4),
              if (connectionErrorModel != null) ...<Widget>[
                Text(
                  connectionErrorModel.message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(
                    color: connectionErrorModel.color,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (_isAutoDisconnected == false) ...<Widget>[
                Text(
                  S.of(context).networkSelectServers,
                  style: textTheme.bodyLarge!.copyWith(
                    color: DesignColors.white1,
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
                        S.of(context).networkServerToConnect,
                        style: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
                      ),
                      const SizedBox(height: 10),
                      NetworkListTile(
                        networkStatusModel: widget.canceledNetworkStatusModel!,
                        onConnected: _handleNetworkConnected,
                        arrowEnabledBool: true,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        S.of(context).networkOtherServers,
                        style: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
                      ),
                      const SizedBox(height: 10),
                    ],
                    NetworkList(
                      onConnected: _handleNetworkConnected,
                      hiddenNetworkStatusModel: _isAutoDisconnected ? widget.canceledNetworkStatusModel : null,
                      emptyListWidget: Text(
                        S.of(context).networkNoAvailable,
                        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                      ),
                      arrowEnabledBool: true,
                    ),
                    NetworkCustomSection(
                      onConnected: _handleNetworkConnected,
                      arrowEnabledBool: true,
                    ),
                    const SizedBox(height: 100),
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
          message: S.of(context).networkServerOfflineReason,
          color: DesignColors.redStatus1,
        );
      case ConnectionErrorType.serverUnhealthy:
        return ConnectionErrorModel(
          message: S.of(context).networkProblemReason,
          color: DesignColors.yellowStatus1,
        );
      default:
        return null;
    }
  }

  bool get _isAutoDisconnected {
    return widget.canceledNetworkStatusModel != null && widget.canceledNetworkStatusModel is! NetworkEmptyModel;
  }

  Future<void> _handleNetworkConnected(ANetworkStatusModel networkStatusModel) async {
    /// delay is required to ensure query parameters are loaded to URI before navigation
    await Future<void>.delayed(const Duration(milliseconds: 100));
    PageRouteInfo<dynamic> nextRoute = RouterUtils.getNextRouteAfterLoading(widget.nextPageRouteInfo);
    await KiraRouter.of(context).navigate(nextRoute);
  }
}
