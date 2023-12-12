import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class StakingListItemDesktop extends StatefulWidget {
  static const double height = 64;
  final ValidatorStakingModel validatorStakingModel;

  const StakingListItemDesktop({
    required this.validatorStakingModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingListItemDesktop();
}

class _StakingListItemDesktop extends State<StakingListItemDesktop> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return StakingListItemDesktopLayout(
      height: StakingListItemDesktop.height,
      infoButtonWidget: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
            StakingDrawerPage(validatorStakingModel: widget.validatorStakingModel),
          ),
          child: const Icon(
            Icons.info_outline,
            color: DesignColors.white2,
            size: 24,
          ),
        ),
      ),
      validatorWidget: AccountTile(
        walletAddress: widget.validatorStakingModel.validatorSimplifiedModel.walletAddress,
        username: widget.validatorStakingModel.validatorSimplifiedModel.moniker,
        avatarUrl: widget.validatorStakingModel.validatorSimplifiedModel.logo,
        addressVisibleBool: false,
      ),
      commissionWidget: Text(
        widget.validatorStakingModel.commission,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white1,
        ),
      ),
      statusWidget: StakingStatusChip(stakingPoolStatus: widget.validatorStakingModel.stakingPoolStatus),
      tokensWidget: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              widget.validatorStakingModel.tokenNames.join(' '),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(
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
                title: S.of(context).stakingTxButtonStake,
                onPressed: _handleStakeButtonPressed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KiraOutlinedButton(
                title: S.of(context).stakingTxUnstake,
                onPressed: _handleUnstakeButtonPressed,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void _handleStakeButtonPressed() {
    KiraRouter.of(context).push(
      TransactionsWrapperRoute(
        children: <PageRouteInfo>[
          StakingTxDelegateRoute(
            stakeableTokens: widget.validatorStakingModel.tokens,
            validatorSimplifiedModel: widget.validatorStakingModel.validatorSimplifiedModel,
          ),
        ],
      ),
    );
  }

  Future<void> _handleUnstakeButtonPressed() async {
    await KiraRouter.of(context).push<void>(
      TransactionsWrapperRoute(
        children: <PageRouteInfo>[
          StakingTxUndelegateRoute(
            validatorSimplifiedModel: widget.validatorStakingModel.validatorSimplifiedModel,
          ),
        ],
      ),
    );
    BlocProvider.of<InfinityListBloc<ValidatorStakingModel>>(context).add(const ListReloadEvent(forceRequestBool: true));
  }
}
