import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_page.dart';
import 'package:miro/views/pages/drawer/validator_drawer_page/validator_drawer_multiple_values_widget.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class ValidatorDrawerStakingPoolSection extends StatelessWidget {
  final bool loadingBool;
  final StakingPoolModel? stakingPoolModel;
  final ValidatorModel validatorModel;
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  ValidatorDrawerStakingPoolSection({
    required this.loadingBool,
    required this.stakingPoolModel,
    required this.validatorModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AuthCubit, Wallet?>(
      bloc: authCubit,
      builder: (BuildContext context, Wallet? wallet) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  S.of(context).stakingPoolDetails,
                  style: textTheme.bodyText1!.copyWith(
                    color: DesignColors.white1,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.tag,
                  color: DesignColors.white2,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  stakingPoolModel?.id.toString() ?? '---',
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.people,
                  color: DesignColors.white2,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  stakingPoolModel?.totalDelegators.toString() ?? '---',
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (authCubit.isSignedIn == false)
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).stakingToEnable,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                  TextLink(
                    text: S.of(context).connectWalletButtonSignIn.toLowerCase(),
                    textStyle: textTheme.caption!,
                    onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(const SignInDrawerPage()),
                  ),
                  Text(
                    S.of(context).toYourAccount,
                    style: textTheme.caption!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 14),
            Row(
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
                          style: textTheme.bodyText2!.copyWith(
                            color: DesignColors.white1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).stakingPoolLabelVotingPower,
                        loadingBool: loadingBool,
                        child: ValidatorDrawerMultipleValuesWidget(
                            values: stakingPoolModel?.votingPower
                                .map((TokenAmountModel e) => '${e.tokenAliasModel.name} ${e.getAmountInLowestDenomination()}')
                                .toList()),
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
                          style: textTheme.bodyText2!.copyWith(
                            color: DesignColors.white1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).stakingPoolLabelTokens,
                        loadingBool: loadingBool,
                        child: ValidatorDrawerMultipleValuesWidget(values: stakingPoolModel?.tokens),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (authCubit.isSignedIn)
              SizedBox(
                height: 36,
                child: KiraOutlinedButton(
                  onPressed: () => _handleStakeButtonPressed(context),
                  title: S.of(context).stakingTxButtonStakeNow.toUpperCase(),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleStakeButtonPressed(BuildContext context) {
    KiraRouter.of(context).navigate(
      PagesWrapperRoute(
        children: <PageRouteInfo>[
          TransactionsWrapperRoute(
            children: <PageRouteInfo>[
              TxDelegateRoute(
                validatorWalletAddress: WalletAddress.fromBech32(validatorModel.walletAddress.bech32Address),
                valoperWalletAddress: WalletAddress.fromBech32(validatorModel.valoperWalletAddress.bech32Address),
              ),
            ],
          )
        ],
      ),
    );
  }
}
