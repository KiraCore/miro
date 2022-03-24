import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_tx.dart';

class WithdrawsTransactions extends TransactionObject {
  @override
  final String hash;
  @override
  final int time;
  @override
  final List<WithdrawsTx> txs;

  WithdrawsTransactions({
    required this.hash,
    required this.time,
    required this.txs,
  });

  factory WithdrawsTransactions.fromJsonWithKey(Map<String, dynamic> json, String key) {
    return WithdrawsTransactions(
      hash: key,
      time: json['time'] as int,
      txs: json['txs'] != null
          ? (json['txs'] as List<dynamic>).map((dynamic e) => WithdrawsTx.fromJson(e as Map<String, dynamic>)).toList()
          : List<WithdrawsTx>.empty(),
    );
  }

  @override
  String toString() {
    return 'WithdrawsTransactions{hash: $hash, time: $time, txs: ${txs.map((WithdrawsTx e) => e.toString())}}';
  }
}
