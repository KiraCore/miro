import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_ir_section.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_staking_pool_section.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_staking_pool_status_chip.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class ValidatorDrawerPage extends StatelessWidget {
  final ValidatorModel validatorModel;

  const ValidatorDrawerPage({
    required this.validatorModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AuthCubit authCubit = globalLocator<AuthCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          title: S.of(context).validatorsAbout,
        ),
        const SizedBox(height: 32),
        BlocBuilder<AuthCubit, Wallet?>(
          bloc: authCubit,
          buildWhen: (Wallet? previous, Wallet? current) => previous?.isMetamask != current?.isMetamask,
          builder: (BuildContext context, Wallet? state) {
            AWalletAddress walletAddress = validatorModel.walletAddress;
            if ((state?.isMetamask == true && walletAddress is CosmosWalletAddress) || (state?.isMetamask != true && walletAddress is EthereumWalletAddress)) {
              walletAddress = walletAddress.toOppositeAddressType();
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: AccountTile(
                    walletAddress: walletAddress,
                    addressVisibleBool: true,
                    username: validatorModel.moniker,
                    avatarUrl: validatorModel.logo,
                  ),
                ),
                const SizedBox(width: 8),
                CopyButton(
                  value: walletAddress.address,
                  notificationText: S.of(context).toastPublicAddressCopied,
                  size: 20,
                ),
                const SizedBox(width: 6),
                KiraToolTip(
                  message: walletAddress.address,
                  child: const Icon(
                    Icons.info_outline,
                    color: DesignColors.white2,
                    size: 20,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableStatus,
                    child: ValidatorStatusChip(validatorStatus: validatorModel.validatorStatus),
                  ),
                  const SizedBox(height: 16),
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableUptime,
                    child: Text(
                      '${validatorModel.uptime}%',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
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
                    prefix: S.of(context).stakingPool,
                    child: ValidatorStakingPoolStatusChip(stakingPoolStatus: validatorModel.stakingPoolStatus),
                  ),
                  const SizedBox(height: 16),
                  PrefixedWidget(
                    prefix: S.of(context).validatorsTableStreak,
                    child: Text(
                      StringUtils.splitBigNumber(validatorModel.streak),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(color: DesignColors.grey1),
        const SizedBox(height: 15),
        ValidatorDrawerIrSection(
          validatorModel: validatorModel,
        ),
        if (validatorModel.stakingPoolStatus != StakingPoolStatus.disabled)
          Column(
            children: <Widget>[
              const Divider(color: DesignColors.grey1),
              const SizedBox(height: 15),
              ValidatorDrawerStakingPoolSection(validatorModel: validatorModel),
            ],
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}
