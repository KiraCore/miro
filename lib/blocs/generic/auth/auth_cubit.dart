import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/global_nav/global_nav_controller.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class AuthCubit extends Cubit<Wallet?> {
  final IdentityRegistrarCubit identityRegistrarCubit = globalLocator<IdentityRegistrarCubit>();

  AuthCubit() : super(null);

  Future<void> signIn(Wallet wallet) async {
    emit(wallet);
    await identityRegistrarCubit.setWalletAddress(wallet.address);
  }

  Future<void> signOut() async {
    emit(null);
    await identityRegistrarCubit.setWalletAddress(null);
    globalLocator<GlobalNavController>().leaveProtectedPage();
  }

  bool get isSignedIn => state != null;
}
