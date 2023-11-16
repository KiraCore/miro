import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';

class LastBlockTimeWidget extends StatefulWidget {
  final DateTime? blockTime;

  const LastBlockTimeWidget({
    required this.blockTime,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LastBlockTimeWidget();
}

class _LastBlockTimeWidget extends State<LastBlockTimeWidget> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    BlockTimeModel? blockTimeModel = widget.blockTime != null ? BlockTimeModel(widget.blockTime!) : null;

    return RichText(
      text: TextSpan(
        text: S.of(context).balancesLastBlockTime,
        style: textTheme.bodySmall!.copyWith(
          color: DesignColors.grey1,
        ),
        children: <TextSpan>[
          TextSpan(
            text: blockTimeModel?.toString() ?? '---',
            style: textTheme.bodySmall!.copyWith(
              color: _selectTextColor(blockTimeModel),
            ),
          ),
          if (blockTimeModel != null && blockTimeModel.isOutdated())
            TextSpan(
              text: S.of(context).balancesTimeSinceBlock(blockTimeModel.durationSinceBlock.inMinutes),
              style: textTheme.bodySmall!.copyWith(
                color: _selectTextColor(blockTimeModel),
              ),
            )
        ],
      ),
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
