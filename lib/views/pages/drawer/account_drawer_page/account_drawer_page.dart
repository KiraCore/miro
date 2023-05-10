import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/generic/account_tile.dart';

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
            AccountTile(walletAddress: wallet!.address),
            const Divider(color: DesignColors.grey2),
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
