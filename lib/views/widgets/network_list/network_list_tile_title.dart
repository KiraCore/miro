import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/views/widgets/generic/network_status_icon.dart';

class NetworkListTileTitle extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;

  const NetworkListTileTitle({
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 12,
              height: 12,
              child: Center(
                child: NetworkStatusIcon(
                  networkStatusModel: networkStatusModel,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              networkStatusModel.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: DesignColors.white_100,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            const SizedBox(width: 20),
            Text(
              networkStatusModel.uri.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: DesignColors.gray2_100,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
        if (_hasErrors) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Found ${_errorsCount} problems with server',
              style: textTheme.caption!.copyWith(
                color: DesignColors.yellow_100,
              ),
            ),
          ),
        ] else
          const SizedBox(height: 8),
      ],
    );
  }

  bool get _hasErrors {
    if (networkStatusModel is NetworkUnhealthyModel) {
      return (networkStatusModel as NetworkUnhealthyModel).interxWarningModel.hasErrors;
    }
    return false;
  }

  int get _errorsCount {
    if (networkStatusModel is NetworkUnhealthyModel) {
      return (networkStatusModel as NetworkUnhealthyModel).interxWarningModel.interxWarningTypes.length;
    }
    return 0;
  }
}
