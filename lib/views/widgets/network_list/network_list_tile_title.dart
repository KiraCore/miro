import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
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
            NetworkStatusIcon(
              networkStatusModel: networkStatusModel,
              size: 12,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                networkStatusModel.name,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText1!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                networkStatusModel.uri.toString(),
                overflow: TextOverflow.ellipsis,
                style: textTheme.caption!.copyWith(
                  color: DesignColors.white2,
                ),
              ),
            ),
          ],
        ),
        if (_hasErrors) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              S.of(context).networkHowManyProblems(_errorsCount),
              style: textTheme.caption!.copyWith(
                color: DesignColors.yellowStatus1,
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
