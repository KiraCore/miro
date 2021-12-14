import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_pub_key.dart';

/// Describes the public key and signing mode of a single top-level signer.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.SignerInfo
class SignerInfo {
  /// The public key is optional for accounts that already exist in state. If unset, the
  /// verifier can use the required signer address for this position and lookup the public key.
  final TxPubKey publicKey;

  /// ModeInfo describes the signing mode of the signer and is a nested
  /// structure to support nested multisig pubkey's
  final ModeInfo modeInfo;

  /// sequence is the sequence of the account, which describes the
  /// number of committed transactions signed by a given address. It is used to prevent
  /// replay attacks.
  final String sequence;

  const SignerInfo({
    required this.publicKey,
    required this.modeInfo,
    required this.sequence,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'public_key': publicKey.toJson(),
        'mode_info': modeInfo.toJson(),
        'sequence': sequence,
      };
}
