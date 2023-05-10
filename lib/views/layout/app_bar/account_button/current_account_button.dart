import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_in_account_button.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_out_account_button.dart';

class CurrentAccountButton extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final Size size;

  CurrentAccountButton({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, Wallet?>(
      bloc: authCubit,
      builder: (BuildContext context, Wallet? wallet) {
        if (authCubit.isSignedIn) {
          return SignedInAccountButton(wallet: wallet!, size: size);
        } else {
          return SignedOutAccountButton(size: size);
        }
      },
    );
  }
}
