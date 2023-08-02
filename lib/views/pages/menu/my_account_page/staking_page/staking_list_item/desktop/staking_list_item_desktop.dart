import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class StakingListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final ValueChanged<bool> onFavouriteButtonPressed;
  final StakingModel stakingModel;

  const StakingListItemDesktop({
    required this.onFavouriteButtonPressed,
    required this.stakingModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    StringBuffer tokenStringBuffer = StringBuffer();
    for (String token in stakingModel.stakingPoolModel.tokens) {
      tokenStringBuffer.write('$token ');
    }

    return StakingListItemDesktopLayout(
      height: height,
      infoButtonWidget: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
            StakingDrawerPage(stakingModel: stakingModel),
          ),
          child: const Icon(
            Icons.info_outline,
            color: DesignColors.white2,
            size: 24,
          ),
        ),
      ),
      validatorWidget: Row(
        children: <Widget>[
          KiraIdentityAvatar(
            address: stakingModel.validatorModel.address,
            size: 40,
          ),
          const SizedBox(width: 12),
          Text(
            stakingModel.validatorModel.moniker,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText1!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ],
      ),
      commissionWidget: Text(
        stakingModel.stakingPoolModel.commission,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyText1!.copyWith(
          color: DesignColors.white1,
        ),
      ),
      statusWidget: StakingStatusTip(validatorStatus: stakingModel.validatorModel.validatorStatus),
      tokensWidget: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              tokenStringBuffer.toString(),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText1!.copyWith(
                color: DesignColors.white1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
