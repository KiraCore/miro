import 'package:miro/infra/dto/api/deposits/response/deposits_tx.dart';

class DepositsTransactions {
  final String hash;
  final int time;
  final List<DepositsTx> txs;

  DepositsTransactions({
    required this.hash,
    required this.time,
    required this.txs,
  });

  factory DepositsTransactions.fromJsonWithKey(Map<String, dynamic> json, String key) {
    return DepositsTransactions(
      hash: key,
      time: json['time'] as int,
      txs: json['txs'] != null
          ? (json['txs'] as List<dynamic>).map((dynamic e) => DepositsTx.fromJson(e as Map<String, dynamic>)).toList()
          : List<DepositsTx>.empty(),
    );
  }

  @override
  String toString() {
    return 'DepositsTransactions{hash: $hash, time: $time, txs: ${txs.map((DepositsTx e) => e.toString())}}';
  }
}
