import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class LastBlockTimeWidget extends StatelessWidget {
  const LastBlockTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      builder: (BuildContext context, NetworkModuleState networkModuleState) {
        BlockTimeModel? blockTimeModel;
        if (networkModuleState.networkStatusModel is ANetworkOnlineModel) {
          ANetworkOnlineModel networkOnlineModel = networkModuleState.networkStatusModel as ANetworkOnlineModel;
          DateTime latestBlockTime = networkOnlineModel.networkInfoModel.latestBlockTime;
          blockTimeModel = BlockTimeModel(latestBlockTime);
        }

        return RichText(
          text: TextSpan(
            text: 'Last block time: ',
            style: textTheme.caption!.copyWith(
              color: DesignColors.gray2_100,
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
                  text: ' (${blockTimeModel.durationSinceBlock.inMinutes} minutes ago)',
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
      return DesignColors.white_100;
    } else if (blockTimeModel.isOutdated()) {
      return DesignColors.red_100;
    } else {
      return DesignColors.darkGreen_100;
    }
  }
}
