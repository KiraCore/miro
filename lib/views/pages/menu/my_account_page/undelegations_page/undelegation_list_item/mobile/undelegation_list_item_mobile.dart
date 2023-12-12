import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class UndelegationListItemMobile extends StatelessWidget {
  final UndelegationModel undelegationModel;

  const UndelegationListItemMobile({
    required this.undelegationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<String> tokens = undelegationModel.tokens.map((TokenAmountModel e) => e.toString()).toList();

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
            walletAddress: undelegationModel.validatorSimplifiedModel.walletAddress,
            username: undelegationModel.validatorSimplifiedModel.moniker,
            avatarUrl: undelegationModel.validatorSimplifiedModel.logo,
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
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).unstakedLabelLockedUntil,
                  child: Text(
                    DateFormat('d MMM y, HH:mm').format(undelegationModel.lockedUntil.toLocal()),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
