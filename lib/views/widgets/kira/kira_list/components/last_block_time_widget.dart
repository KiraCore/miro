import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class LastBlockTimeWidget extends StatelessWidget {
  const LastBlockTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      bloc: globalLocator<NetworkModuleBloc>(),
      builder: (BuildContext context, NetworkModuleState networkModuleState) {
        BlockTimeModel? blockTimeModel;
        if (networkModuleState.networkStatusModel is ANetworkOnlineModel) {
          ANetworkOnlineModel networkOnlineModel = networkModuleState.networkStatusModel as ANetworkOnlineModel;
          DateTime latestBlockTime = networkOnlineModel.networkInfoModel.latestBlockTime;
          blockTimeModel = BlockTimeModel(latestBlockTime);
        }

        return RichText(
          text: TextSpan(
            text: S.of(context).balancesLastBlockTime,
            style: textTheme.caption!.copyWith(
              color: DesignColors.grey1,
            ),
            children: <TextSpan>[
              TextSpan(
                text: blockTimeModel?.toString() ?? '---',
                style: textTheme.caption!.copyWith(
                  color: _selectTextColor(blockTimeModel),
                ),
              ),
              if (blockTimeModel != null && blockTimeModel.isOutdated())
                TextSpan(
                  text: S.of(context).balancesTimeSinceBlock(blockTimeModel.durationSinceBlock.inMinutes),
                  style: textTheme.caption!.copyWith(
                    color: _selectTextColor(blockTimeModel),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Color _selectTextColor(BlockTimeModel? blockTimeModel) {
    if (blockTimeModel == null) {
      return DesignColors.white2;
    } else if (blockTimeModel.isOutdated()) {
      return DesignColors.redStatus1;
    } else {
      return DesignColors.greenStatus1;
    }
  }
}
