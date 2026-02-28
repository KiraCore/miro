import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_transactions/response/transaction.dart';

class QueryTransactionsResp extends Equatable {
  final List<Transaction> transactions;
  final int totalCount;

  const QueryTransactionsResp({
    required this.transactions,
    required this.totalCount,
  });

  factory QueryTransactionsResp.fromJson(Map<String, dynamic> json) {
    int totalCount = json['total_count'] as int? ?? 0;
    if (totalCount == 0 && json['pagination'] != null) {
      final dynamic total =
          (json['pagination'] as Map<String, dynamic>)['total'];
      if (total is int) {
        totalCount = total;
      } else if (total is String) {
        totalCount = int.tryParse(total) ?? 0;
      }
    }

    return QueryTransactionsResp(
      transactions: (json['transactions'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: totalCount,
    );
  }

  @override
  List<Object?> get props => <Object?>[transactions, totalCount];
}
