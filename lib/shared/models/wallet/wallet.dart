import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart' as miro;
import 'package:miro/shared/models/wallet/wallet_address.dart';

/// Represents a wallet which contains the hex private key, the hex public key and the hex address.
/// In order to create one properly, the [Wallet.derive] method should always be used.
/// The associated [walletDetails] will be used when computing the [bech32Address] associated with the wallet.
class Wallet extends Equatable {
  /// Wallet base derivation path
  /// More about:
  /// * https://river.com/learn/terms/d/derivation-path/
  static const String baseDerivationPath = "m/44'/118'/0'/0";

  final WalletAddress address;
  final ECPrivateKey ecPrivateKey;

  const Wallet({
    required this.address,
    required this.ecPrivateKey,
  });

  /// ** HEAVY OPERATION **
  /// Derives the private key from the given [mnemonic] using the specified [walletDetails].
  /// Optionally can define a different derivation path setting [lastDerivationPathSegment].
  ///
  /// Throws [FormatException] if the [int.tryParse] cannot parse [lastDerivationPathSegment]
  static Future<Wallet> derive({
    required miro.Mnemonic mnemonic,
    String lastDerivationPathSegment = '0',
  }) async {
    LegacyHDWallet legacyHDWallet = await LegacyHDWallet.fromMnemonic(
      mnemonic: Mnemonic(mnemonic.array),
      derivationPath: LegacyDerivationPath.parse('$baseDerivationPath/$lastDerivationPathSegment'),
      walletConfig: Bip44WalletsConfig.kira,
    );

    return Wallet(
      address: WalletAddress.fromPublicKey(legacyHDWallet.publicKey.compressed),
      ecPrivateKey: (legacyHDWallet.privateKey as Secp256k1PrivateKey).ecPrivateKey,
    );
  }

  @override
  List<Object?> get props => <Object?>[address, ecPrivateKey];
}
