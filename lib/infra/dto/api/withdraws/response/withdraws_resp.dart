import 'package:miro/infra/dto/api/withdraws/response/withdraws_transactions.dart';

class WithdrawsResp {
  final List<WithdrawsTransactions> transactions;
  final int totalCount;

  WithdrawsResp({
    required this.transactions,
    required this.totalCount,
  });

  factory WithdrawsResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> txs = json['transactions'] as Map<String, dynamic>;

    return WithdrawsResp(
      transactions: txs.keys
          .map<WithdrawsTransactions>(
              (String key) => WithdrawsTransactions.fromJsonWithKey(txs[key] as Map<String, dynamic>, key))
          .toList(),
      totalCount: json['total_count'] as int,
    );
  }

  @override
  String toString() {
    return 'WithdrawsResp{transactions: ${transactions.map((WithdrawsTransactions e) => e.toString())}, '
        'totalCount: ${totalCount}';
  }
}
