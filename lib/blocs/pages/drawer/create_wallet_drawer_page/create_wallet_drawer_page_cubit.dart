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
    Mnemonic mnemonic = Mnemonic.random();
    Wallet wallet = await Wallet.derive(mnemonic: mnemonic);

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
