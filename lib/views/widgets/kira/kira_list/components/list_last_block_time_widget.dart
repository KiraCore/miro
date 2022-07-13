import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/views/widgets/kira/kira_list/models/block_time_model.dart';
import 'package:provider/provider.dart';

class ListLastBlockTimeWidget extends StatelessWidget {
  const ListLastBlockTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (_, NetworkProvider networkProvider, __) {
        String? latestBlockTime = networkProvider.networkModel?.queryInterxStatus?.syncInfo.latestBlockTime;
        BlockTimeModel? blockTimeModel = latestBlockTime != null ? BlockTimeModel.fromString(latestBlockTime) : null;

        return RichText(
          text: TextSpan(
            text: 'Last block time: ',
            style: const TextStyle(
              fontSize: 13,
              color: DesignColors.gray2_100,
            ),
            children: <TextSpan>[
              TextSpan(
                text: blockTimeModel?.toString() ?? '---',
                style: TextStyle(
                  color: _getColor(blockTimeModel),
                ),
              ),
              if (blockTimeModel != null && blockTimeModel.isOutdated())
                TextSpan(
                  text: ' (${blockTimeModel.durationSinceBlock.inMinutes} minutes ago)',
                  style: TextStyle(
                    color: _getColor(blockTimeModel),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Color _getColor(BlockTimeModel? blockTimeModel) {
    if (blockTimeModel == null) {
      return DesignColors.white_100;
    } else if (blockTimeModel.isOutdated()) {
      return DesignColors.red_100;
    } else {
      return DesignColors.darkGreen_100;
    }
  }
}
