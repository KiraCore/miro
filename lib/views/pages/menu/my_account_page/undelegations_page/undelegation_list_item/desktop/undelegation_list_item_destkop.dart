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
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/desktop/undelegation_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class UndelegationListItemDesktop extends StatefulWidget {
  static const double height = 64;
  final UndelegationModel undelegationModel;

  const UndelegationListItemDesktop({
    required this.undelegationModel,
    Key? key,
  }) : super(key: key);

  @override
  State<UndelegationListItemDesktop> createState() => _UndelegationListItemDesktopState();
}

class _UndelegationListItemDesktopState extends State<UndelegationListItemDesktop> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<String> tokens = widget.undelegationModel.tokens.map((TokenAmountModel e) => e.toString()).toList();

    return UndelegationListItemDesktopLayout(
      height: UndelegationListItemDesktop.height,
      validatorWidget: AccountTile(
        walletAddress: widget.undelegationModel.validatorSimplifiedModel.walletAddress,
        addressVisibleBool: false,
        username: widget.undelegationModel.validatorSimplifiedModel.moniker,
        avatarUrl: widget.undelegationModel.validatorSimplifiedModel.logo,
      ),
      tokensWidget: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              tokens.join(' '),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
            ),
          ),
        ],
      ),
      lockedUntilWidget: widget.undelegationModel.isClaimingBlocked()
          ? Text(
              DateFormat('d MMM y, HH:mm').format(widget.undelegationModel.lockedUntil.toLocal()),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
            )
          : Row(
              children: <Widget>[
                KiraOutlinedButton(
                  height: 40,
                  width: 80,
                  title: S.of(context).txHintClaim,
                  onPressed: _handleClaimUndelegationButtonPressed,
                ),
                const Spacer(),
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
