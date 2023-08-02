import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip_model.dart';

class StakingStatusTip extends StatelessWidget {
  final ValidatorStatus validatorStatus;

  const StakingStatusTip({
    required this.validatorStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    StakingStatusChipModel stakingStatusChipModel = _assignValidatorStatusChipModel(context);

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
          style: textTheme.caption!.copyWith(
            color: stakingStatusChipModel.color,
          ),
        ),
      ),
    );
  }

  StakingStatusChipModel _assignValidatorStatusChipModel(BuildContext context) {
    switch (validatorStatus) {
      case ValidatorStatus.active:
        return StakingStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).validatorsActive);
      case ValidatorStatus.inactive:
        return StakingStatusChipModel(color: DesignColors.yellowStatus1, title: S.of(context).validatorsInactive);
      case ValidatorStatus.jailed:
        return StakingStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).validatorsJailed);
      case ValidatorStatus.paused:
        return StakingStatusChipModel(color: DesignColors.white1, title: S.of(context).validatorsPaused);
    }
  }
}
