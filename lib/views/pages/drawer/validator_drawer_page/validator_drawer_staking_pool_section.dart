import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/validator_drawer_page_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/staking_pool_details_grid.dart';

class ValidatorDrawerStakingPoolSection extends StatefulWidget {
  final WalletAddress validatorWalletAddress;

  const ValidatorDrawerStakingPoolSection({
    required this.validatorWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<ValidatorDrawerStakingPoolSection> createState() => _ValidatorDrawerStakingPoolSectionState();
}

class _ValidatorDrawerStakingPoolSectionState extends State<ValidatorDrawerStakingPoolSection> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final ValidatorDrawerPageCubit validatorDrawerPageCubit = ValidatorDrawerPageCubit();

  @override
  void initState() {
    validatorDrawerPageCubit.init(widget.validatorWalletAddress.bech32Address);
    super.initState();
  }

  @override
  void dispose() {
    validatorDrawerPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ValidatorDrawerPageCubit, AValidatorDrawerPageState>(
      bloc: validatorDrawerPageCubit,
      builder: (BuildContext context, AValidatorDrawerPageState validatorDrawerPageState) {
        bool loadingBool = validatorDrawerPageState is ValidatorDrawerPageLoadingState;
        bool errorBool = validatorDrawerPageState is ValidatorDrawerPageErrorState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  S.of(context).stakingPoolDetails,
                  style: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.people,
                  color: DesignColors.white2,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  validatorDrawerPageState.stakingPoolModel?.totalDelegators.toString() ?? '---',
                  style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                ),
              ],
            ),
            const SizedBox(height: 14),
            StakingPoolDetailsGrid(
              errorBool: errorBool,
              loadingBool: loadingBool,
              stakingPoolModel: validatorDrawerPageState.stakingPoolModel,
            ),
          ],
        );
      },
    );
  }
}
