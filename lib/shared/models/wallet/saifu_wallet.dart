
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';

class SaifuWallet extends Wallet {
  @override
  final WalletAddress address;

  @override
  final WalletDetails walletDetails;

  SaifuWallet.fromAddress({
    required this.address,
    this.walletDetails = WalletDetails.defaultWalletDetails,
  });
}
