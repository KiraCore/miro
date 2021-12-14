import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';

/// StdSignDoc is replay-prevention structure.
///
/// https://docs.cosmos.network/master/core/transactions.html
class StdSignDoc {
  /// The account number of the account in state
  final String accountNumber;

  /// The unique identifier of the chain this transaction targets.
  /// It prevents signed transactions from being used on another chain by an attacker
  final String chainId;

  /// Sequence of the account, which describes the number
  /// of committed transactions signed by a given address.
  /// It is used to prevent replay attacks.
  final String sequence;

  /// Any arbitrary note/comment to be added to the transaction.
  final String memo;

  /// Fee includes the amount of coins paid in fees to be used by the transaction.
  final TxFee fee;

  /// List of messages to be executed.
  final List<TxMsg> messages;

  const StdSignDoc({
    required this.chainId,
    required this.accountNumber,
    required this.sequence,
    required this.memo,
    required this.fee,
    required this.messages,
  });

  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'account_number': accountNumber,
      'chain_id': chainId,
      'sequence': sequence,
      'memo': memo,
      'fee': fee.toSignatureJson(),
      'msgs': messages.map((TxMsg e) => e.toSignatureJson()).toList(),
    };
  }
}
