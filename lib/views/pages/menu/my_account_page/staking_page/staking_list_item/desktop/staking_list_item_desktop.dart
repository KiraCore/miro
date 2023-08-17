import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class StakingListItemDesktop extends StatefulWidget {
  static const double height = 64;
  final ValueChanged<bool> onFavouriteButtonPressed;
  final StakingModel stakingModel;

  const StakingListItemDesktop({
    required this.onFavouriteButtonPressed,
    required this.stakingModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingListItemDesktop();
}

class _StakingListItemDesktop extends State<StakingListItemDesktop> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    StakingPoolModel stakingPoolModel = widget.stakingModel.stakingPoolModel;
    ValidatorModel validatorModel = widget.stakingModel.validatorModel;

    StringBuffer tokenStringBuffer = StringBuffer();
    for (String token in stakingPoolModel.tokens) {
      tokenStringBuffer.write('$token ');
    }

    return StakingListItemDesktopLayout(
      height: StakingListItemDesktop.height,
      infoButtonWidget: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
            StakingDrawerPage(stakingModel: widget.stakingModel),
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
            address: validatorModel.walletAddress.bech32Address,
            size: 40,
          ),
          const SizedBox(width: 12),
          Text(
            validatorModel.moniker,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText1!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ],
      ),
      commissionWidget: Text(
        stakingPoolModel.commission,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyText1!.copyWith(
          color: DesignColors.white1,
        ),
      ),
      statusWidget: StakingStatusTip(validatorStatus: validatorModel.validatorStatus),
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
      actionsWidget: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              child: KiraOutlinedButton(
                title: S.of(context).stakingTxDelegate,
                onPressed: _handleDelegateButtonPressed,
                uppercaseBool: true,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  void _handleDelegateButtonPressed() {
    KiraRouter.of(context).navigate(
      PagesWrapperRoute(
        children: <PageRouteInfo>[
          TransactionsWrapperRoute(
            children: <PageRouteInfo>[
              TxDelegateRoute(
                validatorWalletAddress: WalletAddress.fromBech32(widget.stakingModel.validatorModel.walletAddress.bech32Address),
                valoperWalletAddress: WalletAddress.fromBech32(widget.stakingModel.validatorModel.valoperWalletAddress.bech32Address),
              ),
            ],
          )
        ],
      ),
    );
  }
}
