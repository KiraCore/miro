import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/auth_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_body.dart';

/// Standard type used for broadcasting transactions.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.Tx
class SignedTransaction {
  /// Processable content of the transaction
  final TxBody body;

  /// Authorization related content of the transaction,
  /// specifically signers, signer modes and fee
  final AuthInfo authInfo;

  /// List of signatures that matches the length and order of
  /// AuthInfo's signer_infos to allow connecting signature meta information like
  /// public key and signing mode by position.
  final List<String> signatures;

  const SignedTransaction({
    required this.body,
    required this.authInfo,
    required this.signatures,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'body': body.toJson(),
        'auth_info': authInfo.toJson(),
        'signatures': signatures,
      };
}
