import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
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

    return BlocProvider<SignInDrawerPageCubit>(
      create: (BuildContext context) => SignInDrawerPageCubit(),
      child: BlocConsumer<MetamaskCubit, MetamaskState>(
        bloc: metamaskCubit,
        listenWhen: (MetamaskState previous, MetamaskState current) => previous.isConnected != current.isConnected,
        listener: (BuildContext context, MetamaskState metamaskState) {
          KiraScaffold.of(context).closeEndDrawer();
        },
        builder: (BuildContext context, MetamaskState metamaskState) {
          return BlocBuilder<SignInDrawerPageCubit, SignInDrawerPageState>(
            builder: (BuildContext context, SignInDrawerPageState signInDrawerPageState) {
              bool disabledBool = signInDrawerPageState.disabledBool;

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
                    disabled: disabledBool,
                    onPressed: () {
                      KiraScaffold.of(context).navigateEndDrawerRoute(const SignInKeyfileDrawerPage());
                    },
                  ),
                  const SizedBox(height: 16),
                  KiraElevatedButton(
                    title: S.of(context).mnemonic,
                    disabled: disabledBool,
                    onPressed: () {
                      KiraScaffold.of(context).navigateEndDrawerRoute(const SignInMnemonicDrawerPage());
                    },
                  ),
                  if (metamaskCubit.isSupported) ...<Widget>[
                    const SizedBox(height: 16),
                    KiraElevatedButton(
                      title: S.of(context).metamask,
                      disabled: disabledBool,
                      onPressed: metamaskCubit.connect,
                    ),
                  ],
                  const SizedBox(height: 16),
                  KiraElevatedButton(
                    title: S.of(context).signInPrivateKey,
                    disabled: disabledBool,
                    onPressed: () {
                      KiraScaffold.of(context).navigateEndDrawerRoute(const SignInPrivateKeyDrawerPage());
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    S.of(context).createWalletDontHave,
                    style: textTheme.bodyMedium!.copyWith(
                      color: disabledBool ? DesignColors.grey2 : DesignColors.white1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  KiraOutlinedButton(
                    title: S.of(context).createWalletButton,
                    disabled: disabledBool,
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
    );
  }
}
