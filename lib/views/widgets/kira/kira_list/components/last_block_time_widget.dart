import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

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
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.of(context).balancesLastBlockTime,
            style: textTheme.bodySmall!.copyWith(
              color: DesignColors.grey1,
            ),
          ),
          Text(
            _buildBlockTimeMessage(blockTimeModel),
            style: textTheme.bodySmall!.copyWith(
              color: _selectTextColor(blockTimeModel),
            ),
          ),
          const SizedBox(height: 6),
        ],
      );
    } else {
      return RichText(
        text: TextSpan(
          text: S.of(context).balancesLastBlockTime,
          style: textTheme.bodySmall!.copyWith(
            color: DesignColors.grey1,
          ),
          children: <TextSpan>[
            TextSpan(
              text: _buildBlockTimeMessage(blockTimeModel),
              style: textTheme.bodySmall!.copyWith(
                color: _selectTextColor(blockTimeModel),
              ),
            ),
          ],
        ),
      );
    }
  }

  String _buildBlockTimeMessage(BlockTimeModel? blockTimeModel) {
    String text = '---';
    if (blockTimeModel != null) {
    text = DateFormat('d MMM y, HH:mm').format(blockTimeModel.blockTime.toLocal());
    }
    if (blockTimeModel != null && blockTimeModel.isOutdated()) {
      text = text + S.of(context).balancesTimeSinceBlock(blockTimeModel.durationSinceBlock.inMinutes);
    }
    return text;
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
