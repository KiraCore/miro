import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/generic/account/account_header.dart';

class AccountDrawerPage extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  AccountDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, Wallet?>(
      bloc: authCubit,
      builder: (_, Wallet? wallet) {
        if (authCubit.isSignedIn == false) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
              bloc: globalLocator<IdentityRegistrarCubit>(),
              builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
                return AccountHeader(irModel: identityRegistrarState.irModel);
              },
            ),
            const SizedBox(height: 8),
            const Divider(color: DesignColors.grey2),
            const SizedBox(height: 8),
            SizedBox(
              height: 500,
              child: AccountMenuList(onItemTap: () => KiraScaffold.of(context).closeEndDrawer()),
            ),
          ],
        );
      },
    );
  }
}
