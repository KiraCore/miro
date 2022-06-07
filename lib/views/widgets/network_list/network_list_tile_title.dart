import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

class NetworkListTileTitle extends StatelessWidget {
  final Color foregroundColor;
  final ANetworkStatusModel networkStatusModel;

  const NetworkListTileTitle({
    required this.foregroundColor,
    required this.networkStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: SvgPicture.asset(
                  Assets.iconsNetworkStatus,
                  color: foregroundColor,
                  height: 12,
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
              ),
            ),
          ],
        ),
        if (hasErrors) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Found ${errorsCount} problems with server',
              style: const TextStyle(
                fontSize: 12,
                color: DesignColors.yellow_100,
              ),
            ),
          ),
        ] else
          const SizedBox(height: 8),
      ],
    );
  }

  bool get hasErrors {
    if (networkStatusModel is NetworkUnhealthyModel) {
      return (networkStatusModel as NetworkUnhealthyModel).interxWarningModel.hasErrors;
    }
    return false;
  }

  int get errorsCount {
    if (networkStatusModel is NetworkUnhealthyModel) {
      return (networkStatusModel as NetworkUnhealthyModel).interxWarningModel.interxWarningTypes.length;
    }
    return 0;
  }
}
