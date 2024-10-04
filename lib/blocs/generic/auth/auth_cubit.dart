import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/global_nav/global_nav_controller.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class AuthCubit extends Cubit<Wallet?> {
  final IdentityRegistrarCubit _identityRegistrarCubit;

  AuthCubit()
      : _identityRegistrarCubit = globalLocator<IdentityRegistrarCubit>(),
        super(null);

  Future<void> signIn(Wallet wallet) async {
    if (wallet.isMetamask) {
      await _identityRegistrarCubit.setWalletAddress(CosmosWalletAddress.fromEthereum(wallet.address.address));
      if (state?.address is CosmosWalletAddress) {
        emit(Wallet(
          address: CosmosWalletAddress.fromEthereum(wallet.address.address),
        ));
        return;
      }
    } else {
      await _identityRegistrarCubit.setWalletAddress(wallet.address);
    }
    emit(wallet);
  }

  Future<void> signOut() async {
    emit(null);
    await _identityRegistrarCubit.setWalletAddress(null);
    globalLocator<GlobalNavController>().leaveProtectedPage();
  }

  void toggleWalletAddress() {
    if (state == null) {
      return;
    }
    emit(Wallet(
      address: state!.address.toOppositeAddressType(),
      ecPrivateKey: state!.ecPrivateKey,
    ));
  }

  /// Only KIRA address can be used as identity (for Balances / Transactions / etc.)
  CosmosWalletAddress? get identityStateAddress {
    if (state == null) {
      return null;
    }
    if (state!.isMetamask) {
      return CosmosWalletAddress.fromEthereum(state!.address.address);
    }
    return state!.address as CosmosWalletAddress;
  }

  bool get isSignedIn => state != null;
}
