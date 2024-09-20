import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/account_drawer_page/account_drawer_page.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class MyAccountButtonMobile extends StatelessWidget {
  final Size size;
  final Wallet wallet;

  const MyAccountButtonMobile({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
      bloc: globalLocator<IdentityRegistrarCubit>(),
      builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
        Widget buttonWidget = KiraIdentityAvatar(
          loadingBool: identityRegistrarState is IdentityRegistrarLoadingState,
          address: wallet.address.address,
          avatarUrl: identityRegistrarState.irModel?.avatarIRRecordModel.value,
          size: size.height,
        );

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _handleNavigation(context),
            child: buttonWidget,
          ),
        );
      },
    );
  }

  Future<void> _handleNavigation(BuildContext context) async {
    KiraScaffold.of(context).navigateEndDrawerRoute(AccountDrawerPage());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    Backdrop.of(context).collapse();
  }
}
