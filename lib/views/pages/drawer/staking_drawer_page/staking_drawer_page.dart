import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class StakingDrawerPage extends StatefulWidget {
  final StakingModel stakingModel;

  const StakingDrawerPage({required this.stakingModel, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingDrawerPage();
}

class _StakingDrawerPage extends State<StakingDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    StakingPoolModel stakingPoolModel = widget.stakingModel.stakingPoolModel;
    ValidatorModel validatorModel = widget.stakingModel.validatorModel;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          title: '${validatorModel.moniker} ${S.of(context).stakingPool}',
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Icon(
              Icons.tag,
              color: DesignColors.white2,
            ),
            const SizedBox(width: 4),
            Text(
              stakingPoolModel.id.toString(),
              style: textTheme.bodyText1!.copyWith(
                color: DesignColors.white2,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.people,
              color: DesignColors.white2,
            ),
            const SizedBox(width: 4),
            Text(
              stakingPoolModel.totalDelegators.toString(),
              style: textTheme.bodyText1!.copyWith(
                color: DesignColors.white2,
              ),
            ),
            const SizedBox(width: 12),
            StakingStatusTip(validatorStatus: validatorModel.validatorStatus),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: <Widget>[
            KiraIdentityAvatar(
              address: validatorModel.walletAddress.bech32Address,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    validatorModel.moniker,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      color: DesignColors.white1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    validatorModel.walletAddress.bech32Address,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2!.copyWith(
                      color: DesignColors.grey1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).stakingPoolLabelCommission,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.accent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stakingPoolModel.commission,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      color: DesignColors.white1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).stakingPoolLabelVotingPower,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.accent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  for (TokenAmountModel tokenAmountModel in stakingPoolModel.votingPower)
                    Text(
                      '${tokenAmountModel.tokenAliasModel.name} ${tokenAmountModel.getAmountInLowestDenomination()}',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1!.copyWith(
                        color: DesignColors.white1,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).stakingPoolLabelSlashed,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.accent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stakingPoolModel.slashed,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      color: DesignColors.white1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).stakingPoolLabelTokens,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.accent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  for (String token in stakingPoolModel.tokens)
                    Text(
                      token,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1!.copyWith(
                        color: DesignColors.white1,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: KiraOutlinedButton(
                  onPressed: _handleDelegateButtonPressed,
                  title: S.of(context).stakingTxDelegate,
                  uppercaseBool: true,
                ),
              ),
            ],
          ),
        ),
      ],
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
