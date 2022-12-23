import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip_model.dart';

class ValidatorStatusTip extends StatelessWidget {
  final ValidatorStatus validatorStatus;

  const ValidatorStatusTip({
    required this.validatorStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ValidatorStatusChipModel validatorStatusChipModel = _validatorStatusChipModel;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: validatorStatusChipModel.color.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          validatorStatusChipModel.title,
          style: textTheme.caption!.copyWith(
            color: validatorStatusChipModel.color,
          ),
        ),
      ),
    );
  }

  ValidatorStatusChipModel get _validatorStatusChipModel {
    switch (validatorStatus) {
      case ValidatorStatus.active:
        return const ValidatorStatusChipModel(color: DesignColors.darkGreen_100, title: 'Active');
      case ValidatorStatus.inactive:
        return const ValidatorStatusChipModel(color: DesignColors.blue1_100, title: 'Inactive');
      case ValidatorStatus.jailed:
        return const ValidatorStatusChipModel(color: DesignColors.red_100, title: 'Jailed');
      case ValidatorStatus.paused:
        return const ValidatorStatusChipModel(color: DesignColors.blue1_100, title: 'Paused');
      case ValidatorStatus.waiting:
        return const ValidatorStatusChipModel(color: DesignColors.blue1_100, title: 'Waiting');
    }
  }
}
