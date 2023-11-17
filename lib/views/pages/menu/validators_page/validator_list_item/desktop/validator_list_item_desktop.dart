import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_page.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/desktop/validator_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_staking_pool_status_chip.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class ValidatorListItemDesktop extends StatelessWidget {
  static const double height = 64;

  final ValidatorModel validatorModel;
  final ValueChanged<bool> onFavouriteButtonPressed;

  const ValidatorListItemDesktop({
    required this.validatorModel,
    required this.onFavouriteButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ValidatorListItemDesktopLayout(
      height: height,
      infoButtonWidget: MouseStateListener(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
          ValidatorDrawerPage(validatorModel: validatorModel),
        ),
        childBuilder: (Set<MaterialState> states) {
          return const Icon(
            Icons.info_outline,
            color: DesignColors.white2,
            size: 24,
          );
        },
      ),
      topWidget: Text(
        validatorModel.top.toString(),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
      ),
      monikerWidget: AccountTile(
        walletAddress: validatorModel.walletAddress,
        addressVisibleBool: false,
        username: validatorModel.moniker,
        avatarUrl: validatorModel.logo,
      ),
      streakWidget: Text(
        StringUtils.splitBigNumber(validatorModel.streak),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      statusWidget: ValidatorStatusChip(validatorStatus: validatorModel.validatorStatus),
      uptimeWidget: Text(
        '${validatorModel.uptime}%',
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      stakingPoolWidget: ValidatorStakingPoolStatusChip(
        stakingPoolStatus: validatorModel.stakingPoolStatus,
      ),
      favouriteButtonWidget: StarButton(
        key: Key('fav_validator_${validatorModel.moniker}'),
        onChanged: onFavouriteButtonPressed,
        size: 20,
        value: validatorModel.isFavourite,
      ),
    );
  }
}
