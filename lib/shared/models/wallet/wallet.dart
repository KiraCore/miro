import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';

abstract class Wallet extends Equatable {
  /// The wallet address instance
  WalletAddress get address;

  /// The wallet hex public key
  Uint8List get publicKey;

  /// Blockchain network details
  WalletDetails get walletDetails;

  /// Returns the associated [publicKey] as a Bech32 string
  String get bech32PublicKey {
    final List<int> type = <int>[235, 90, 233, 135, 33];
    final String prefix = '${walletDetails.bech32Hrp}pub';
    final Uint8List fullPublicKey = Uint8List.fromList(type + publicKey);
    return Bech32.encode(prefix, fullPublicKey);
  }

  @override
  List<Object> get props => <Object>[address];
}
