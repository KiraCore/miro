import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_page.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_staking_pool_status_chip.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class ValidatorListItemMobile extends StatelessWidget {
  final ValidatorModel validatorModel;
  final ValueChanged<bool> onFavouriteButtonPressed;

  const ValidatorListItemMobile({
    required this.validatorModel,
    required this.onFavouriteButtonPressed,
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
              SizedBox(
                width: 30,
                child: Text(
                  validatorModel.top.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                ),
              ),
              Expanded(
                child: AccountTile(
                  walletAddress: validatorModel.walletAddress,
                  addressVisibleBool: false,
                  username: validatorModel.moniker,
                  avatarUrl: validatorModel.logo,
                ),
              ),
              StarButton(
                key: Key('fav_validator_${validatorModel.moniker}'),
                onChanged: onFavouriteButtonPressed,
                size: 20,
                value: validatorModel.isFavourite,
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).validatorsTableStatus,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                    const SizedBox(height: 6),
                    ValidatorStatusChip(validatorStatus: validatorModel.validatorStatus),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).stakingPool,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                    const SizedBox(height: 6),
                    ValidatorStakingPoolStatusChip(
                      stakingPoolStatus: validatorModel.stakingPoolStatus,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).validatorsTableUptime,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${validatorModel.uptime}%',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).validatorsTableStreak,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StringUtils.splitBigNumber(validatorModel.streak),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          KiraOutlinedButton(
            onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(
              ValidatorDrawerPage(validatorModel: validatorModel),
            ),
            title: S.of(context).showDetails,
          ),
        ],
      ),
    );
  }
}
