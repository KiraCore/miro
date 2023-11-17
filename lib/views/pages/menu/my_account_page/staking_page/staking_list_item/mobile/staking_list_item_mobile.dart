import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/staking_drawer_page/staking_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/text_column.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class StakingListItemMobile extends StatelessWidget {
  final ValidatorStakingModel validatorStakingModel;

  const StakingListItemMobile({
    required this.validatorStakingModel,
    Key? key,
  }) : super(key: key);

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
          Row(
            children: <Widget>[
              KiraIdentityAvatar(
                address: validatorStakingModel.validatorSimplifiedModel.walletAddress.bech32Address,
                size: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  validatorStakingModel.validatorSimplifiedModel.moniker.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge!.copyWith(
                    color: DesignColors.white1,
                  ),
                ),
              ),
            ],
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
                  child: StakingStatusChip(stakingPoolStatus: validatorStakingModel.stakingPoolStatus),
                ),
              ),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelCommission,
                  child: Text(
                    validatorStakingModel.commission,
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
                    itemList: validatorStakingModel.tokens,
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
              StakingDrawerPage(validatorStakingModel: validatorStakingModel),
            ),
          ),
        ],
      ),
    );
  }
}
