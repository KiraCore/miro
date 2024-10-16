import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart' as miro;

/// Represents a wallet which contains the hex private key, the hex public key and the hex address.
/// In order to create one properly, the [Wallet.derive] method should always be used.
/// The associated [walletDetails] will be used when computing the [bech32Address] associated with the wallet.
class Wallet extends Equatable {
  /// Wallet base derivation path
  /// More about:
  /// * https://river.com/learn/terms/d/derivation-path/
  static const String baseDerivationPath = "m/44'/118'/0'/0";

  final AWalletAddress address;
  final ECPrivateKey? ecPrivateKey;

  const Wallet({
    required this.address,
    this.ecPrivateKey,
  });

  factory Wallet.fromEthereumPrivateKey(String ethPrivateKey) {
    ECPrivateKey ecPrivateKey = ECPrivateKey.fromBytes(HexCodec.decode(ethPrivateKey), CurvePoints.generatorSecp256k1);
    return Wallet(
      address: EthereumWalletAddress.fromPrivateKey(ecPrivateKey),
      ecPrivateKey: ecPrivateKey,
    );
  }

  /// ** HEAVY OPERATION **
  /// Derives the private key from the given [mnemonic] using the specified [walletDetails].
  /// Optionally can define a different derivation path setting [lastDerivationPathSegment] (>=0).
  static Future<Wallet> derive({
    required miro.Mnemonic mnemonic,
    int lastDerivationPathSegment = 0,
  }) async {
    assert(lastDerivationPathSegment >= 0, 'Invalid index format');

    LegacyHDWallet legacyHDWallet = await LegacyHDWallet.fromMnemonic(
      mnemonic: Mnemonic(mnemonic.array),
      derivationPath: LegacyDerivationPath.parse('$baseDerivationPath/$lastDerivationPathSegment'),
      walletConfig: Bip44WalletsConfig.kira,
    );

    return Wallet(
      address: CosmosWalletAddress.fromPublicKey(legacyHDWallet.publicKey.compressed),
      ecPrivateKey: (legacyHDWallet.privateKey as Secp256k1PrivateKey).ecPrivateKey,
    );
  }

  bool get isEthereum => address is EthereumWalletAddress;

  @override
  List<Object?> get props => <Object?>[address, ecPrivateKey];
}
