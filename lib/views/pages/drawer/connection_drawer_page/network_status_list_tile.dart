import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/network_connect_button.dart';
import 'package:provider/provider.dart';

class NetworkStatusListTile extends StatefulWidget {
  final NetworkModel networkModel;

  const NetworkStatusListTile({
    required this.networkModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkStatusListTile();
}

class _NetworkStatusListTile extends State<NetworkStatusListTile> {
  final TextStyle networkDetailsTextStyle = const TextStyle(
    color: DesignColors.gray2_100,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (_, NetworkProvider networkProvider, Widget? child) {
        bool isActualConnectedNetwork = networkProvider.networkUri == widget.networkModel.parsedUri;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: isActualConnectedNetwork ? DesignColors.darkGreen_100 : const Color(0xFF4E4C71),
            ),
            color: isActualConnectedNetwork ? DesignColors.darkGreen_100.withOpacity(0.1) : Colors.transparent,
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
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12,
                            height: 12,
                            child: Center(
                              child: _buildNetworkHealthStatusWidget(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.networkModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: DesignColors.white_100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 20),
                          Text(
                            widget.networkModel.parsedUri.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: DesignColors.gray2_100,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  collapsedIconColor: Colors.white,
                  children: <Widget>[
                    const SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Block Height',
                            style: networkDetailsTextStyle,
                          ),
                          Text(
                            widget.networkModel.queryInterxStatus?.syncInfo.latestBlockHeight ?? '---',
                            style: networkDetailsTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Validators',
                            style: networkDetailsTextStyle,
                          ),
                          Text(
                            _getValidatorsCount(),
                            style: networkDetailsTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  const SizedBox(width: 35),
                  NetworkConnectButton(
                    networkModel: widget.networkModel,
                    isConnected: isActualConnectedNetwork,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildNetworkHealthStatusWidget() {
    switch (widget.networkModel.status) {
      case NetworkHealthStatus.online:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.green,
          height: 12,
        );
      case NetworkHealthStatus.unknown:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.grey,
          height: 12,
        );
      default:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.red,
          height: 12,
        );
    }
  }

  String _getValidatorsCount() {
    if (widget.networkModel.queryValidatorsResp?.status != null) {
      return '${widget.networkModel.queryValidatorsResp!.status!.activeValidators}/${widget.networkModel.queryValidatorsResp!.status!.totalValidators}';
    }
    return '---';
  }
}
