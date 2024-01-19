import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32_pair.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';

/// Represents an wallet address.
/// Source: https://github.com/LmFlutterSDK/web3dart/blob/master/lib/src/credentials/address.dart
class WalletAddress extends Equatable {
  /// The length of a wallet address, in bytes.
  static const int addressByteLength = 20;

  final Uint8List addressBytes;

  final String? _bech32Hrp;

  /// Stores raw address bytes and allows to create bech32Address based on hrp (human readable part).
  const WalletAddress({
    required this.addressBytes,
    String? bech32Hrp,
  })  : _bech32Hrp = bech32Hrp,
        assert(addressBytes.length == addressByteLength, 'Address should be $addressByteLength bytes length');

  /// Constructs a wallet address from a public key. The address is formed by
  /// the last 20 bytes of the keccak hash of the public key.
  factory WalletAddress.fromPublicKey(Uint8List publicKey) {
    return WalletAddress(addressBytes: Secp256k1.publicKeyToAddress(publicKey));
  }

  // Hrp data extracted from QueryTokenAliases
  factory WalletAddress.fromBech32(String bech32Address) {
    final Bech32Pair bech32pair = Bech32.decode(bech32Address);
    return WalletAddress(addressBytes: bech32pair.data);
  }

  // Hrp data extracted from QueryValidators
  factory WalletAddress.fromBech32ValidatorsPage(String bech32Address) {
    final Bech32Pair bech32pair = Bech32.decode(bech32Address);
    return WalletAddress(addressBytes: bech32pair.data, bech32Hrp: bech32pair.hrp);
  }

  /// Returns the associated [address] as a Bech32 string.
  String get bech32Address {
    String bech32Hrp = _bech32Hrp ?? globalLocator<NetworkModuleBloc>().tokenDefaultDenomModel.bech32AddressPrefix!;
    return Bech32.encode(bech32Hrp, addressBytes);
  }

  /// Returns the associated [address] as a Bech32 string.
  String buildBech32AddressShort({required String delimiter}) {
    String address = bech32Address;
    String firstPart = address.substring(0, 8);
    String lastPart = address.substring(address.length - 4, address.length);
    return '${firstPart}$delimiter$lastPart';
  }

  @override
  List<Object?> get props => <Object>[addressBytes];
}
