import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';

enum WalletAddressType { ethereum, cosmos }

abstract class AWalletAddress extends Equatable {
  /// The length of a wallet address, in bytes.
  static const int addressByteLength = 20;

  final Uint8List addressBytes;

  /// Stores raw address bytes.
  const AWalletAddress({
    required this.addressBytes,
  }) : assert(addressBytes.length == addressByteLength, 'Address should be $addressByteLength bytes length, not ${addressBytes.length}');

  factory AWalletAddress.fromAddress(String address) {
    if (address.substring(0, 2) == '0x') {
      return EthereumWalletAddress.fromString(address);
    }
    return CosmosWalletAddress.fromBech32(address);
  }

  factory AWalletAddress.fromValidatorAddress(String address) {
    if (address.substring(0, 2) == '0x') {
      return EthereumWalletAddress.fromString(address);
    }
    return CosmosWalletAddress.fromBech32Validators(address);
  }

  String get address;

  WalletAddressType get type;

  /// Returns the associated [address] as a string.
  String buildShortAddress({required String delimiter}) {
    String ad = address;
    String firstPart = ad.substring(0, 8);
    String lastPart = ad.substring(ad.length - 4, ad.length);
    return '${firstPart}$delimiter$lastPart';
  }

  @override
  List<Object?> get props => <Object>[addressBytes];
}
