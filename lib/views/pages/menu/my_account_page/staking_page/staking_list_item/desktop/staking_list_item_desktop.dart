import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class StakingListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final ValidatorStakingModel validatorStakingModel;

  const StakingListItemDesktop({
    required this.validatorStakingModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return StakingListItemDesktopLayout(
      height: height,
      infoButtonWidget: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
            StakingDrawerPage(validatorStakingModel: validatorStakingModel),
          ),
          child: const Icon(
            Icons.info_outline,
            color: DesignColors.white2,
            size: 24,
          ),
        ),
      ),
      validatorWidget: AccountTile(
        walletAddress: validatorStakingModel.validatorSimplifiedModel.walletAddress,
        username: validatorStakingModel.validatorSimplifiedModel.moniker,
        avatarUrl: validatorStakingModel.validatorSimplifiedModel.logo,
        addressVisibleBool: false,
      ),
      commissionWidget: Text(
        validatorStakingModel.commission,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white1,
        ),
      ),
      statusWidget: StakingStatusChip(stakingPoolStatus: validatorStakingModel.stakingPoolStatus),
      tokensWidget: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              validatorStakingModel.tokenNames.join(' '),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(
                color: DesignColors.white1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
