import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip_model.dart';

class StakingStatusChip extends StatelessWidget {
  final StakingPoolStatus stakingPoolStatus;

  const StakingStatusChip({
    required this.stakingPoolStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    StakingStatusChipModel stakingStatusChipModel = _assignStakingPoolStatusChipModel(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: stakingStatusChipModel.color.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          stakingStatusChipModel.title,
          style: textTheme.bodySmall!.copyWith(
            color: stakingStatusChipModel.color,
          ),
        ),
      ),
    );
  }

  StakingStatusChipModel _assignStakingPoolStatusChipModel(BuildContext context) {
    switch (stakingPoolStatus) {
      case StakingPoolStatus.enabled:
        return StakingStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).stakingPoolStatusEnabled);
      case StakingPoolStatus.withdraw:
        return StakingStatusChipModel(color: DesignColors.yellowStatus1, title: S.of(context).stakingPoolStatusWithdraw);
      case StakingPoolStatus.disabled:
        return StakingStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).stakingPoolStatusDisabled);
    }
  }
}
