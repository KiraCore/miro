import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/drawer/drawer_title.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_ir_section.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_staking_pool_section.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_staking_pool_status_chip.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class ValidatorDrawerPage extends StatefulWidget {
  final ValidatorModel validatorModel;

  const ValidatorDrawerPage({
    required this.validatorModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorDrawerPage();
}

class _ValidatorDrawerPage extends State<ValidatorDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String address = widget.validatorModel.walletAddress.bech32Address;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          title: S.of(context).validatorsAbout,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AccountTile(
                walletAddress: widget.validatorModel.walletAddress,
                addressVisibleBool: true,
                username: widget.validatorModel.moniker,
                avatarUrl: widget.validatorModel.logo,
              ),
            ),
            const SizedBox(width: 8),
            CopyButton(
              value: address,
              notificationText: S.of(context).toastPublicAddressCopied,
              size: 20,
            ),
            const SizedBox(width: 6),
            KiraToolTip(
              message: address,
              child: const Icon(
                Icons.info_outline,
                color: DesignColors.white2,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableStatus,
                    child: ValidatorStatusChip(validatorStatus: widget.validatorModel.validatorStatus),
                  ),
                  const SizedBox(height: 16),
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableUptime,
                    child: Text(
                      '${widget.validatorModel.uptime}%',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PrefixedWidget(
                    prefix: S.of(context).stakingPool,
                    child: ValidatorStakingPoolStatusChip(stakingPoolStatus: widget.validatorModel.stakingPoolStatus),
                  ),
                  const SizedBox(height: 16),
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableStreak,
                    child: Text(
                      StringUtils.splitBigNumber(widget.validatorModel.streak),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(color: DesignColors.grey1),
        const SizedBox(height: 15),
        ValidatorDrawerIrSection(
          validatorModel: widget.validatorModel,
        ),
        if (widget.validatorModel.stakingPoolStatus != StakingPoolStatus.disabled)
          Column(
            children: <Widget>[
              const Divider(color: DesignColors.grey1),
              const SizedBox(height: 15),
              ValidatorDrawerStakingPoolSection(validatorModel: widget.validatorModel),
            ],
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}
