import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/blocs/specific_blocs/views/pages/drawer/create_wallet_page/a_create_wallet_page_state.dart';
import 'package:miro/blocs/specific_blocs/views/pages/drawer/create_wallet_page/states/create_wallet_page_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/views/pages/drawer/create_wallet_page/states/create_wallet_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class CreateWalletPageCubit extends Cubit<ACreateWalletPageState> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final ValueNotifier<bool> termsCheckedNotifier = ValueNotifier<bool>(false);

  CreateWalletPageCubit() : super(CreateWalletPageLoadingState());

  Future<void> generateNewAddress() async {
    emit(CreateWalletPageLoadingState());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    Mnemonic mnemonic = Mnemonic.random();
    Wallet wallet = Wallet.derive(mnemonic: mnemonic);

    emit(CreateWalletPageLoadedState(mnemonic: mnemonic, wallet: wallet));
  }

  void signIn() {
    if (state is CreateWalletPageLoadedState) {
      authCubit.signIn((state as CreateWalletPageLoadedState).wallet);
    } else {
      throw Exception('Wallet must me generated before sign in');
    }
  }
}
