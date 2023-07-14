import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/views/widgets/network_list/network_warning_container.dart';

class NetworkListTileContent extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;

  const NetworkListTileContent({
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle networkDetailsTextStyle = textTheme.caption!.copyWith(
      color: DesignColors.white2,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 35, right: 20),
      child: Column(
        children: <Widget>[
          if (networkStatusModel is NetworkUnhealthyModel) ...<Widget>[
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (networkStatusModel as NetworkUnhealthyModel).interxWarningModel.interxWarningTypes.length,
              itemBuilder: (BuildContext context, int index) {
                NetworkUnhealthyModel networkUnhealthyModel = networkStatusModel as NetworkUnhealthyModel;
                InterxWarningType interxWarningType = networkUnhealthyModel.interxWarningModel.interxWarningTypes[index];
                return NetworkWarningContainer(
                  interxWarningType: interxWarningType,
                  latestBlockTime: _blockTime,
                );
              },
            ),
          ],
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(S.of(context).networkBlockTime, style: networkDetailsTextStyle),
              Text(_blockTime, style: networkDetailsTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(S.of(context).networkBlockHeight, style: networkDetailsTextStyle),
              Text(_latestBlockHeight, style: networkDetailsTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(S.of(context).validators, style: networkDetailsTextStyle),
              Text(_validatorsCount, style: networkDetailsTextStyle),
            ],
          ),
        ],
      ),
    );
  }

  String get _latestBlockHeight {
    if (networkStatusModel is ANetworkOnlineModel) {
      return (networkStatusModel as ANetworkOnlineModel).networkInfoModel.latestBlockHeight.toString();
    }
    return '---';
  }

  String get _validatorsCount {
    if (networkStatusModel is ANetworkOnlineModel) {
      int? activeValidators = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.activeValidators;
      int? totalValidators = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.totalValidators;
      return '${activeValidators ?? '---'}/${totalValidators ?? '---'}';
    }
    return '---/---';
  }

  String get _blockTime {
    if (networkStatusModel is ANetworkOnlineModel) {
      DateTime latestBlockTime = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.latestBlockTime.toLocal();
      return DateFormat('dd.MM.yyyy HH:mm').format(latestBlockTime);
    }
    return '---';
  }
}
