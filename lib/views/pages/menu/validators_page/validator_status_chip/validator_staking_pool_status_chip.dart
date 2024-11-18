import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip_model.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';

class ValidatorStakingPoolStatusChip extends StatelessWidget {
  final StakingPoolStatus stakingPoolStatus;

  const ValidatorStakingPoolStatusChip({
    required this.stakingPoolStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValidatorStatusChipModel validatorStatusChipModel = _assignValidatorStatusChipModel(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: StatusChip(
        text: validatorStatusChipModel.title,
        color: validatorStatusChipModel.color,
      ),
    );
  }

  ValidatorStatusChipModel _assignValidatorStatusChipModel(BuildContext context) {
    switch (stakingPoolStatus) {
      case StakingPoolStatus.enabled:
        return ValidatorStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).stakingPoolStatusEnabled);
      case StakingPoolStatus.withdraw:
        return ValidatorStatusChipModel(color: DesignColors.yellowStatus1, title: S.of(context).stakingPoolStatusWithdraw);
      case StakingPoolStatus.disabled:
        return ValidatorStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).stakingPoolStatusDisabled);
    }
  }
}
