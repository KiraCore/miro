import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/views/widgets/network_list/network_warning_container.dart';

const TextStyle kNetworkDetailsTextStyle = TextStyle(
  color: DesignColors.gray2_100,
  fontSize: 12,
);

class NetworkListTileContent extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;

  const NetworkListTileContent({
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  latestBlockTime: blockTime,
                );
              },
            ),
          ],
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Block time', style: kNetworkDetailsTextStyle),
              Text(blockTime, style: kNetworkDetailsTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Block Height', style: kNetworkDetailsTextStyle),
              Text(latestBlockHeight, style: kNetworkDetailsTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Validators', style: kNetworkDetailsTextStyle),
              Text(validatorsCount, style: kNetworkDetailsTextStyle),
            ],
          ),
        ],
      ),
    );
  }

  String get latestBlockHeight {
    if (networkStatusModel is ANetworkOnlineModel) {
      return (networkStatusModel as ANetworkOnlineModel).networkInfoModel.latestBlockHeight.toString();
    }
    return '---';
  }

  String get validatorsCount {
    if (networkStatusModel is ANetworkOnlineModel) {
      int? activeValidators = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.activeValidators;
      int? totalValidators = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.totalValidators;
      return '${activeValidators ?? '---'}/${totalValidators ?? '---'}';
    }
    return '---/---';
  }

  String get blockTime {
    if (networkStatusModel is ANetworkOnlineModel) {
      DateTime latestBlockTime = (networkStatusModel as ANetworkOnlineModel).networkInfoModel.latestBlockTime.toLocal();
      return DateFormat('HH:mm dd.MM.yyyy').format(latestBlockTime);
    }
    return '---';
  }
}
