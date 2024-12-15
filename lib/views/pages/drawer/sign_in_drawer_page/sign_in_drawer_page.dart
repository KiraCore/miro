import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_drawer_page/create_wallet_drawer_page.dart';
import 'package:miro/views/pages/drawer/network_drawer_page/network_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_warning_section.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_mnemonic_drawer_page/sign_in_mnemonic_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_private_key_drawer_page/sign_in_private_key_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class SignInDrawerPage extends StatelessWidget {
  const SignInDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    MetamaskCubit metamaskCubit = globalLocator<MetamaskCubit>();
    AuthCubit authCubit = globalLocator<AuthCubit>();

    return BlocProvider<SignInDrawerPageCubit>(
      create: (BuildContext context) => SignInDrawerPageCubit(),
      child: BlocListener<AuthCubit, Wallet?>(
        bloc: authCubit,
        listenWhen: (Wallet? previous, Wallet? current) => (previous == null) != (current == null),
        listener: (BuildContext context, Wallet? state) {
          if (authCubit.isEthereumSession) {
            KiraScaffold.of(context).closeEndDrawer();
          }
        },
        child: BlocConsumer<MetamaskCubit, MetamaskState>(
          bloc: metamaskCubit,
          listener: (BuildContext context, MetamaskState metamaskState) {
            if (metamaskState.needRequestForSignaturePermissionBool) {
              _showSignaturePurposeExplanationDialog(context, metamaskCubit);
            }
          },
          builder: (BuildContext context, MetamaskState metamaskState) {
            return BlocBuilder<SignInDrawerPageCubit, SignInDrawerPageState>(
              builder: (BuildContext context, SignInDrawerPageState signInDrawerPageState) {
                bool disabledBool = signInDrawerPageState.disabledBool;
                bool loadingBool = signInDrawerPageState.refreshingBool || metamaskState.isLoadingBool;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    DrawerTitle(
                      title: S.of(context).connectWallet,
                      subtitle: disabledBool ? S.of(context).connectWalletWarning : S.of(context).connectWalletOptions,
                      subtitleColor: disabledBool ? DesignColors.yellowStatus1 : DesignColors.accent,
                    ),
                    if (disabledBool) ...<Widget>[
                      const SizedBox(height: 26),
                      SignInDrawerWarningSection(
                        refreshingBool: signInDrawerPageState.refreshingBool,
                        expirationDateTime: signInDrawerPageState.refreshUnlockingDateTime,
                        changeNetworkButtonPressed: () {
                          KiraScaffold.of(context).navigateEndDrawerRoute(const NetworkDrawerPage());
                        },
                      ),
                    ],
                    const SizedBox(height: 32),
                    KiraElevatedButton(
                      title: S.of(context).keyfile,
                      disabled: disabledBool || loadingBool,
                      onPressed: () {
                        KiraScaffold.of(context).navigateEndDrawerRoute(const SignInKeyfileDrawerPage());
                      },
                    ),
                    const SizedBox(height: 16),
                    KiraElevatedButton(
                      title: S.of(context).mnemonic,
                      disabled: disabledBool || loadingBool,
                      onPressed: () {
                        KiraScaffold.of(context).navigateEndDrawerRoute(const SignInMnemonicDrawerPage());
                      },
                    ),
                    if (metamaskCubit.isSupported) ...<Widget>[
                      const SizedBox(height: 16),
                      KiraElevatedButton(
                        loadingBool: metamaskState.isLoadingBool,
                        title: S.of(context).metamask,
                        disabled: disabledBool || loadingBool,
                        onPressed: metamaskCubit.connect,
                      ),
                    ],
                    const SizedBox(height: 16),
                    KiraElevatedButton(
                      title: S.of(context).signInPrivateKey,
                      disabled: disabledBool || loadingBool,
                      onPressed: () {
                        KiraScaffold.of(context).navigateEndDrawerRoute(const SignInPrivateKeyDrawerPage());
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      S.of(context).createWalletDontHave,
                      style: textTheme.bodyMedium!.copyWith(
                        color: disabledBool || loadingBool ? DesignColors.grey2 : DesignColors.white1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    KiraOutlinedButton(
                      title: S.of(context).createWalletButton,
                      disabled: disabledBool || loadingBool,
                      onPressed: () {
                        KiraScaffold.of(context).navigateEndDrawerRoute(const CreateWalletDrawerPage());
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showSignaturePurposeExplanationDialog(BuildContext context, MetamaskCubit metamaskCubit) {
    TextTheme textTheme = Theme.of(context).textTheme;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(
          S.of(context).metamaskSignatureExplanationDialogTitle,
          style: textTheme.titleMedium!.copyWith(color: DesignColors.white1),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(
            S.of(context).metamaskSignatureExplanationDialogMessage,
            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1, height: 1.25),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(DesignColors.greyTransparent),
            ),
            onPressed: () {
              metamaskCubit.resolveUserSignatureApproval(isApproved: true);
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).metamaskSignatureExplanationDialogButtonProceed,
              style: textTheme.labelLarge!.copyWith(color: DesignColors.white1),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(DesignColors.greyTransparent),
            ),
            onPressed: () {
              metamaskCubit.resolveUserSignatureApproval(isApproved: false);
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).metamaskSignatureExplanationDialogButtonCancel,
              style: textTheme.labelLarge!.copyWith(color: DesignColors.white2),
            ),
          ),
        ],
      ),
    );
  }
}
