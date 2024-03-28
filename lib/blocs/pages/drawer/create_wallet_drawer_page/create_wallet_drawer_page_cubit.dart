import 'package:cryptography_utils/cryptography_utils.dart' as crypto_utils;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/a_create_wallet_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/states/create_wallet_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/states/create_wallet_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class CreateWalletDrawerPageCubit extends Cubit<ACreateWalletDrawerPageState> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final ValueNotifier<bool> termsCheckedNotifier = ValueNotifier<bool>(false);

  CreateWalletDrawerPageCubit() : super(CreateWalletDrawerPageLoadingState());

  @override
  Future<void> close() async {
    termsCheckedNotifier.dispose();
    await super.close();
  }

  Future<void> generateNewAddress() async {
    emit(CreateWalletDrawerPageLoadingState());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    crypto_utils.Mnemonic cryptoUtilsMnemonic = crypto_utils.Mnemonic.generate(mnemonicSize: crypto_utils.MnemonicSize.words24);

    crypto_utils.LegacyHDWallet legacyHDWallet = await crypto_utils.LegacyHDWallet.fromMnemonic(
      mnemonic: cryptoUtilsMnemonic,
      walletConfig: crypto_utils.Bip44WalletsConfig.kira,
      derivationPathString: "m/44'/118'/0'/0/0",
    );

    Mnemonic mnemonic = Mnemonic.fromArray(array: cryptoUtilsMnemonic.mnemonicList);
    Wallet wallet = Wallet.fromLegacyHDWallet(legacyHDWallet);

    emit(CreateWalletDrawerPageLoadedState(mnemonic: mnemonic, wallet: wallet));
  }

  void signIn() {
    if (state is CreateWalletDrawerPageLoadedState) {
      authCubit.signIn((state as CreateWalletDrawerPageLoadedState).wallet);
    } else {
      throw Exception('Wallet must me generated before sign in');
    }
  }
}
