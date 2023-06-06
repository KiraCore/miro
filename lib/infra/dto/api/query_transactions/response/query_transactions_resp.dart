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
    return QueryTransactionsResp(
      transactions: (json['transactions'] as List<dynamic>? ?? <dynamic>[]).map((dynamic e) => Transaction.fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: json['total_count'] as int,
    );
  }

  @override
  List<Object?> get props => <Object?>[transactions, totalCount];
}
