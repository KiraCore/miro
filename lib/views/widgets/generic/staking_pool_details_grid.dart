import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/text_column.dart';

class StakingPoolDetailsGrid extends StatelessWidget {
  final bool errorBool;
  final bool loadingBool;
  final StakingPoolModel? stakingPoolModel;

  const StakingPoolDetailsGrid({
    required this.errorBool,
    required this.loadingBool,
    required this.stakingPoolModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (errorBool) {
      return Text(
        S.of(context).errorCannotFetchData,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.redStatus1),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelCommission,
                  loadingBool: loadingBool,
                  child: Text(
                    stakingPoolModel?.commission ?? '---',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                  ),
                ),
                const SizedBox(height: 16),
                PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelVotingPower,
                  loadingBool: loadingBool,
                  child: TextColumn<TokenAmountModel>(
                    itemList: stakingPoolModel?.votingPower,
                    displayItemAsString: (TokenAmountModel item) => item.toString(),
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
                  prefix: S.of(context).stakingPoolLabelSlashed,
                  loadingBool: loadingBool,
                  child: Text(
                    stakingPoolModel?.slashed ?? '---',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                  ),
                ),
                const SizedBox(height: 16),
                PrefixedWidget(
                  prefix: S.of(context).stakingPoolLabelTokens,
                  loadingBool: loadingBool,
                  child: TextColumn<TokenAliasModel>(
                    itemList: stakingPoolModel?.tokens,
                    displayItemAsString: (TokenAliasModel item) => item.networkTokenDenominationModel.name,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
