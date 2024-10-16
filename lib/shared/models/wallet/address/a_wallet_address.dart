import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';

enum WalletAddressType { ethereum, cosmos }

extension AWalletAddressStringExtension on String {
  /// String might have wallet address inside. If so, it will be replaced with a new type of the address.
  String replaceAddressTypeIfExists({required WalletAddressType toType}) {
    return split(' ').map((String word) {
      switch (toType) {
        case WalletAddressType.cosmos:
          if (word.substring(0, 2) == '0x') {
            return CosmosWalletAddress.fromEthereum(word).address;
          }
        case WalletAddressType.ethereum:
          if (word.substring(0, 4) == 'kira') {
            return EthereumWalletAddress.fromBech32(word).address;
          }
      }
      return word;
    }).join(' ');
  }
}

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

  /// Returns the opposite address type (Ethereum -> Cosmos, Cosmos -> Ethereum)
  AWalletAddress toOppositeAddressType() {
    if (this is EthereumWalletAddress) {
      return CosmosWalletAddress.fromEthereum(address);
    } else if (this is CosmosWalletAddress) {
      return EthereumWalletAddress.fromBech32(address);
    }
    throw UnsupportedError('Type of address is not supported - $runtimeType');
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
