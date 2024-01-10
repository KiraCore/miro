import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';
import 'package:pointycastle/export.dart';

/// Represents a wallet which contains the hex private key, the hex public key and the hex address.
/// In order to create one properly, the [Wallet.derive] method should always be used.
/// The associated [walletDetails] will be used when computing the [bech32Address] associated with the wallet.
class Wallet extends Equatable {
  /// Wallet base derivation path
  /// More about:
  /// * https://river.com/learn/terms/d/derivation-path/
  static const String baseDerivationPath = "m/44'/118'/0'/0";

  /// The wallet hex address
  final WalletAddress address;

  /// The wallet hex private key
  final Uint8List privateKey;

  const Wallet({
    required this.address,
    required this.privateKey,
  });

  /// ** HEAVY OPERATION **
  /// Derives the private key from the given [mnemonic] using the specified [walletDetails].
  /// Optionally can define a different derivation path setting [lastDerivationPathSegment].
  ///
  /// Throws [FormatException] if the [int.tryParse] cannot parse [lastDerivationPathSegment]
  factory Wallet.derive({
    required Mnemonic mnemonic,
    String lastDerivationPathSegment = '0',
  }) {
    final int lastDerivationPathSegmentCheck = int.tryParse(lastDerivationPathSegment) ?? -1;
    if (lastDerivationPathSegmentCheck < 0) {
      throw FormatException('Invalid index format $lastDerivationPathSegment');
    }

    // Convert the mnemonic to a BIP32 instance
    final bip32.BIP32 root = bip32.BIP32.fromSeed(mnemonic.seed);

    // Get the node from the derivation path
    final bip32.BIP32 derivedNode = root.derivePath('$baseDerivationPath/$lastDerivationPathSegment');

    // Get the public key
    final Uint8List publicKeyBytes = Secp256k1.privateKeyBytesToPublic(derivedNode.privateKey!);

    return Wallet(
      address: WalletAddress.fromPublicKey(publicKeyBytes),
      privateKey: derivedNode.privateKey!,
    );
  }

  factory Wallet.fromKeyfileData(Map<String, dynamic> publicData, Map<String, dynamic> secretData) {
    final WalletAddress walletAddress = WalletAddress.fromBech32(publicData['bech32Address'] as String);
    final Uint8List privateKey = Uint8List.fromList(HEX.decode(secretData['privateKey'] as String));

    return Wallet(
      address: walletAddress,
      privateKey: privateKey,
    );
  }

  /// Returns the associated [publicKey] as an [ECPublicKey] instance.
  ECPublicKey get ecPublicKey {
    final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();
    final ECPoint point = secp256k1.G;
    final ECPoint? curvePoint = point * ecPrivateKey.d;
    return ECPublicKey(curvePoint, ECCurve_secp256k1());
  }

  /// Returns the associated [privateKey] as an [ECPrivateKey] instance.
  ECPrivateKey get ecPrivateKey {
    final BigInt privateKeyInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    return ECPrivateKey(privateKeyInt, ECCurve_secp256k1());
  }

  @override
  List<Object?> get props => <Object?>[address, privateKey];
}
