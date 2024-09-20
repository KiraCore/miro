import 'package:auto_route/auto_route.dart';
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
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/staking_pool_details_grid.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class ValidatorDrawerStakingPoolSection extends StatefulWidget {
  final ValidatorModel validatorModel;

  const ValidatorDrawerStakingPoolSection({
    required this.validatorModel,
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
    validatorDrawerPageCubit.init(widget.validatorModel.walletAddress.address);
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
            if (authCubit.isSignedIn == false) ...<Widget>[
              RichText(
                text: TextSpan(
                  text: S.of(context).stakingToEnable,
                  style: textTheme.bodySmall!.copyWith(color: DesignColors.white2),
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: TextLink(
                        text: S.of(context).connectWalletButtonSignIn.toLowerCase(),
                        textStyle: textTheme.bodySmall!,
                        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(const SignInDrawerPage()),
                      ),
                    ),
                    TextSpan(text: S.of(context).toYourAccount),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
            StakingPoolDetailsGrid(
              errorBool: errorBool,
              loadingBool: loadingBool,
              stakingPoolModel: validatorDrawerPageState.stakingPoolModel,
            ),
            const SizedBox(height: 20),
            if (authCubit.isSignedIn && validatorDrawerPageState.stakingPoolModel != null)
              SizedBox(
                height: 36,
                child: KiraOutlinedButton(
                  onPressed: () => _handleStakeButtonPressed(context, validatorDrawerPageState.stakingPoolModel!),
                  title: S.of(context).stakingTxButtonStake,
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleStakeButtonPressed(BuildContext context, StakingPoolModel stakingPoolModel) {
    KiraRouter.of(context).push(
      TransactionsWrapperRoute(
        children: <PageRouteInfo>[
          StakingTxDelegateRoute(
            stakeableTokens: stakingPoolModel.tokens,
            validatorSimplifiedModel: widget.validatorModel.validatorSimplifiedModel,
          ),
        ],
      ),
    );
  }
}
