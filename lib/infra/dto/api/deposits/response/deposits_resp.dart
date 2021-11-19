import 'package:miro/infra/dto/api/deposits/response/deposits_transactions.dart';

class DepositsResp {
  final List<DepositsTransactions> transactions;
  final int totalCount;

  DepositsResp({
    required this.transactions,
    required this.totalCount,
  });

  factory DepositsResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> txs = json['transactions'] as Map<String, dynamic>;

    return DepositsResp(
      transactions: txs.keys
          .map<DepositsTransactions>((String key) => DepositsTransactions.fromJsonWithKey(txs[key] as Map<String, dynamic>, key))
          .toList(),
      totalCount: json['total_count'] as int,
    );
  }

  @override
  String toString() {
    return 'DepositsResp{transactions: ${transactions.map((DepositsTransactions e) => e.toString())}, totalCount: $totalCount}';
  }
}