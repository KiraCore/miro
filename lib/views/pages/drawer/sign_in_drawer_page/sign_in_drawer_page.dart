import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/layout/drawer/drawer_title.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_drawer_page/create_wallet_drawer_page.dart';
import 'package:miro/views/pages/drawer/network_drawer_page/network_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_warning_section.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_mnemonic_drawer_page/sign_in_mnemonic_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class SignInDrawerPage extends StatefulWidget {
  const SignInDrawerPage({Key? key}) : super(key: key);

  @override
  State<SignInDrawerPage> createState() => _SignInDrawerPageState();
}

class _SignInDrawerPageState extends State<SignInDrawerPage> {
  final SignInDrawerPageCubit _signInDrawerPageCubit = SignInDrawerPageCubit();

  @override
  void dispose() {
    _signInDrawerPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SignInDrawerPageCubit, SignInDrawerPageState>(
      bloc: _signInDrawerPageCubit,
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
  }
}
