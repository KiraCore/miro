import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/validator_drawer_page_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_ir_section.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_staking_pool_section.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_staking_pool_status_chip.dart';
import 'package:miro/views/pages/menu/validators_page/validator_status_chip/validator_status_chip.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class ValidatorDrawerPage extends StatefulWidget {
  final ValidatorModel validatorModel;

  const ValidatorDrawerPage({
    required this.validatorModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorAboutDrawerPage();
}

class _ValidatorAboutDrawerPage extends State<ValidatorDrawerPage> {
  final ValidatorDrawerPageCubit stakingPoolDrawerCubit = ValidatorDrawerPageCubit();

  @override
  void initState() {
    super.initState();
    stakingPoolDrawerCubit.loadStakingPoolByAddress(widget.validatorModel.walletAddress.bech32Address);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String address = widget.validatorModel.walletAddress.bech32Address;

    return BlocBuilder<ValidatorDrawerPageCubit, AValidatorDrawerPageState>(
      bloc: stakingPoolDrawerCubit,
      builder: (BuildContext context, AValidatorDrawerPageState stakingPoolDrawerState) {
        bool loadingBool = stakingPoolDrawerState is ValidatorDrawerPageLoadingState;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerTitle(
              title: S.of(context).validatorsAbout,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                KiraIdentityAvatar(
                  address: address,
                  size: 35,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.validatorModel.moniker,
                        maxLines: 1,
                        style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        WalletAddress.fromBech32(address).buildBech32AddressShort(delimiter: '...'),
                        style: textTheme.caption!.copyWith(color: DesignColors.white2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                CopyButton(
                  value: address,
                  notificationText: S.of(context).toastPublicAddressCopied,
                  size: 20,
                ),
                const SizedBox(width: 6),
                KiraToolTip(
                  message: address,
                  child: const Icon(
                    Icons.info_outline,
                    color: DesignColors.white2,
                    size: 20,
                  ),
                ),
              ],
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
                        loadingBool: loadingBool,
                        child: ValidatorStatusChip(validatorStatus: widget.validatorModel.validatorStatus),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).validatorsTableUptime,
                        loadingBool: loadingBool,
                        child: Text(
                          '${widget.validatorModel.uptime}%',
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText2!.copyWith(
                            color: DesignColors.white1,
                          ),
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
                        loadingBool: loadingBool,
                        child: ValidatorStakingPoolStatusChip(stakingPoolStatus: widget.validatorModel.stakingPoolStatus),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).validatorsTableStreak,
                        loadingBool: loadingBool,
                        child: Text(
                          StringUtils.splitBigNumber(widget.validatorModel.streak),
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText2!.copyWith(
                            color: DesignColors.white1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: DesignColors.grey2),
            const SizedBox(height: 15),
            ValidatorDrawerIrSection(
              loadingBool: loadingBool,
              irModel: stakingPoolDrawerState.irModel,
            ),
            if (widget.validatorModel.stakingPoolStatus != StakingPoolStatus.disabled)
              Column(
                children: <Widget>[
                  const Divider(color: DesignColors.grey2),
                  const SizedBox(height: 15),
                  ValidatorDrawerStakingPoolSection(
                    loadingBool: loadingBool,
                    stakingPoolModel: stakingPoolDrawerState.stakingPoolModel,
                    validatorModel: widget.validatorModel,
                  ),
                ],
              ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
