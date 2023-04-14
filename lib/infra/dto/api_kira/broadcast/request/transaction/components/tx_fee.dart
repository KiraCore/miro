import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/coin.dart';

/// Fee includes the amount of coins paid in fees and the maximum gas to be used by the transaction.
/// The ratio yields an effective "gasprice", which must be above some miminum to be accepted into the mempool.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.Fee
class TxFee extends Equatable {
  /// Amount of coins to be paid as a fee
  final List<Coin> amount;

  /// The maximum gas that can be used in transaction processing before an out of gas error occurs
  // TODO(dominik): We do not use gas in Kira Network, but the backend requires this variable. Delete when not needed
  final String gasLimit;

  const TxFee({
    required this.amount,
    this.gasLimit = '999999',
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount.map((Coin e) => e.toJson()).toList(),
        'gas_limit': gasLimit,
      };

  Map<String, dynamic> toSignatureJson() => <String, dynamic>{
        'amount': amount.map((Coin e) => e.toJson()).toList(),
        'gas': gasLimit,
      };

  @override
  List<Object?> get props => <Object?>[amount, gasLimit];
}
