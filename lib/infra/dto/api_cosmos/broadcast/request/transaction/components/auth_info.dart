import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/signer_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';

/// Describes the fee and signer modes that are used to sign a transaction.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.AuthInfo
class AuthInfo {
  /// Defines the signing modes for the required signers. The number
  /// and order of elements must match the required signers from TxBody's messages.
  /// The first element is the primary signer and the one which pays the fee.
  final List<SignerInfo> signerInfos;

  /// The fee can be calculated based on the cost of evaluating
  /// the body and doing signature verification of the signers.
  /// This can be estimated via simulation.
  final TxFee fee;

  AuthInfo({
    required this.fee,
    required this.signerInfos,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'signer_infos': signerInfos.map((SignerInfo e) => e.toJson()).toList(),
        'fee': fee.toJson(),
      };
}
