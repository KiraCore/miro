import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';
import 'package:miro/shared/utils/cryptography/bech32.dart';
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

  /// The wallet hex public key
  final Uint8List publicKey;

  /// Blockchain network details
  final WalletDetails walletDetails;

  const Wallet({
    required this.address,
    required this.privateKey,
    required this.publicKey,
    this.walletDetails = WalletDetails.defaultWalletDetails,
  });

  /// ** HEAVY OPERATION **
  /// Derives the private key from the given [mnemonic] using the specified [walletDetails].
  /// Optionally can define a different derivation path setting [lastDerivationPathSegment].
  ///
  /// Throws [FormatException] if the [int.tryParse] cannot parse [lastDerivationPathSegment]
  factory Wallet.derive({
    required Mnemonic mnemonic,
    String lastDerivationPathSegment = '0',
    WalletDetails walletDetails = WalletDetails.defaultWalletDetails,
  }) {
    final int _lastDerivationPathSegmentCheck = int.tryParse(lastDerivationPathSegment) ?? -1;
    if (_lastDerivationPathSegmentCheck < 0) {
      throw FormatException('Invalid index format $lastDerivationPathSegment');
    }

    // Convert the mnemonic to a BIP32 instance
    final bip32.BIP32 root = bip32.BIP32.fromSeed(mnemonic.seed);

    // Get the node from the derivation path
    final bip32.BIP32 derivedNode = root.derivePath('$baseDerivationPath/$lastDerivationPathSegment');

    // Get the public key
    final Uint8List publicKeyBytes = Secp256k1.privateKeyBytesToPublic(derivedNode.privateKey!);

    return Wallet(
      address: WalletAddress.fromPublicKey(publicKeyBytes, bech32Hrp: walletDetails.bech32Hrp),
      publicKey: publicKeyBytes,
      privateKey: derivedNode.privateKey!,
      walletDetails: walletDetails,
    );
  }

  factory Wallet.fromKeyFileData(Map<String, dynamic> publicData, Map<String, dynamic> secretData) {
    final Uint8List address = Uint8List.fromList(HEX.decode(publicData['address'] as String));
    final WalletDetails walletDetails = WalletDetails.fromJson(publicData['walletDetails'] as Map<String, dynamic>);
    return Wallet(
      address: WalletAddress(addressBytes: address, bech32Hrp: walletDetails.bech32Hrp),
      privateKey: Uint8List.fromList(HEX.decode(secretData['privateKey'] as String)),
      publicKey: Uint8List.fromList(HEX.decode(publicData['publicKey'] as String)),
    );
  }

  /// Returns the associated [publicKey] as a Bech32 string
  String get bech32PublicKey {
    final List<int> type = <int>[235, 90, 233, 135, 33];
    final String prefix = '${walletDetails.bech32Hrp}pub';
    final Uint8List fullPublicKey = Uint8List.fromList(type + publicKey);
    return Bech32.encode(prefix, fullPublicKey);
  }

  // TODO(dominik): For future use. Elliptic Curve public key, probably can be used in transactions
  /// Returns the associated [publicKey] as an [ECPublicKey] instance.
  ECPublicKey get ecPublicKey {
    final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();
    final ECPoint point = secp256k1.G;
    final ECPoint? curvePoint = point * ecPrivateKey.d;
    return ECPublicKey(curvePoint, ECCurve_secp256k1());
  }

  // TODO(dominik): For future use. Elliptic Curve private key, probably can be used in transactions
  /// Returns the associated [privateKey] as an [ECPrivateKey] instance.
  ECPrivateKey get ecPrivateKey {
    final BigInt privateKeyInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    return ECPrivateKey(privateKeyInt, ECCurve_secp256k1());
  }

  /// Converts the current [Wallet] instance into a JSON object.
  /// Note that the private key is not serialized for safety reasons.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'hexAddress': HEX.encode(address.addressBytes),
        'bech32Address': address.bech32Address,
        'publicKey': HEX.encode(publicKey),
        'walletDetails': walletDetails.toJson(),
      };
  
  @override
  List<Object?> get props => <Object?>[address, privateKey, publicKey, walletDetails];
}
