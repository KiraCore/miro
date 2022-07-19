import 'dart:typed_data';

import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';

class SaifuWallet extends Wallet {
  @override
  final WalletAddress address;

  @override
  final Uint8List publicKey;

  @override
  final WalletDetails walletDetails;

  SaifuWallet.fromAddress({
    required this.address,
    this.walletDetails = WalletDetails.defaultWalletDetails,
  }) : publicKey = Bech32.decode(address.bech32Address).data;
}
