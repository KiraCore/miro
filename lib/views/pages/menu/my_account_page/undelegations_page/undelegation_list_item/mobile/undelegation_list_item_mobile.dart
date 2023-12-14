import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class UndelegationListItemMobile extends StatefulWidget {
  final UndelegationModel undelegationModel;

  const UndelegationListItemMobile({
    required this.undelegationModel,
    Key? key,
  }) : super(key: key);

  @override
  State<UndelegationListItemMobile> createState() => _UndelegationListItemMobileState();
}

class _UndelegationListItemMobileState extends State<UndelegationListItemMobile> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<String> tokens = widget.undelegationModel.tokens.map((TokenAmountModel e) => e.toString()).toList();

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
            walletAddress: widget.undelegationModel.validatorSimplifiedModel.walletAddress,
            username: widget.undelegationModel.validatorSimplifiedModel.moniker,
            avatarUrl: widget.undelegationModel.validatorSimplifiedModel.logo,
            size: 46,
            usernameTextStyle: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
            addressTextStyle: textTheme.bodyMedium!.copyWith(color: DesignColors.grey1),
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelTokens,
                  child: Text(
                    tokens.join(' '),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                  ),
                ),
              ),
              if (widget.undelegationModel.isClaimingBlocked())
                Expanded(
                  child: PrefixedWidget(
                    prefix: S.of(context).unstakedLabelLockedUntil,
                    child: Text(
                      DateFormat('d MMM y, HH:mm').format(widget.undelegationModel.lockedUntil.toLocal()),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          if (widget.undelegationModel.isClaimingBlocked() == false)
            KiraOutlinedButton(
              height: 40,
              title: S.of(context).txHintClaim,
              onPressed: _handleClaimUndelegationButtonPressed,
            ),
        ],
      ),
    );
  }

  Future<void> _handleClaimUndelegationButtonPressed() async {
    await KiraRouter.of(context).push<void>(
      TransactionsWrapperRoute(
        children: <PageRouteInfo>[
          StakingTxClaimUndelegationRoute(
            tokenAmountModel: widget.undelegationModel.tokens.first,
            undelegationId: widget.undelegationModel.id,
            validatorWalletAddress: widget.undelegationModel.validatorSimplifiedModel.walletAddress,
          ),
        ],
      ),
    );
    BlocProvider.of<InfinityListBloc<UndelegationModel>>(context).add(const ListReloadEvent(forceRequestBool: true));
  }
}
