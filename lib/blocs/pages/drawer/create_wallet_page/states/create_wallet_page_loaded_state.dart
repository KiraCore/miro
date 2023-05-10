import 'package:miro/blocs/pages/drawer/create_wallet_page/a_create_wallet_page_state.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class CreateWalletPageLoadedState extends ACreateWalletPageState {
  final Mnemonic mnemonic;
  final Wallet wallet;

  const CreateWalletPageLoadedState({
    required this.mnemonic,
    required this.wallet,
  });
  
  @override
  List<Object> get props => <Object>[mnemonic, wallet];
}
