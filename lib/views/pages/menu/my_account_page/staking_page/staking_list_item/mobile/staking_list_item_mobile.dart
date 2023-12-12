import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/text_column.dart';

class StakingListItemMobile extends StatefulWidget {
  final ValidatorStakingModel validatorStakingModel;

  const StakingListItemMobile({
    required this.validatorStakingModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingListItemMobile();
}

class _StakingListItemMobile extends State<StakingListItemMobile> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          AccountTile(
            walletAddress: widget.validatorStakingModel.validatorSimplifiedModel.walletAddress,
            username: widget.validatorStakingModel.validatorSimplifiedModel.moniker,
            avatarUrl: widget.validatorStakingModel.validatorSimplifiedModel.logo,
            addressVisibleBool: false,
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).validatorsTableStatus,
                  child: StakingStatusChip(stakingPoolStatus: widget.validatorStakingModel.stakingPoolStatus),
                ),
              ),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelCommission,
                  child: Text(
                    widget.validatorStakingModel.commission,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge!.copyWith(
                      color: DesignColors.white1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelTokens,
                  child: TextColumn<TokenAliasModel>(
                    itemList: widget.validatorStakingModel.tokens,
                    displayItemAsString: (TokenAliasModel tokenAliasModel) => '${tokenAliasModel.name} ',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          KiraOutlinedButton(
            height: 40,
            title: S.of(context).showDetails,
            onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(
              StakingDrawerPage(validatorStakingModel: widget.validatorStakingModel),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
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
              ],
            ),
          ),
        ],
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
