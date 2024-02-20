import 'package:miro/infra/dto/api/query_transaction_result/response/msg.dart';
import 'package:miro/infra/dto/api/query_transactions/response/transaction.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/response/fee.dart';

class QueryTransactionResultResp {
  final String hash;
  final String status;
  final int blockHeight;
  final int blockTimestamp;
  final int confirmation;
  final List<Msg> msgs;
  final List<Transaction> transactions;
  final List<Fee> fees;
  final int gasWanted;
  final int gasUsed;
  final String memo;

  QueryTransactionResultResp({
    required this.hash,
    required this.status,
    required this.blockHeight,
    required this.blockTimestamp,
    required this.confirmation,
    required this.msgs,
    required this.transactions,
    required this.fees,
    required this.gasWanted,
    required this.gasUsed,
    required this.memo,
  });

  factory QueryTransactionResultResp.fromJson(Map<String, dynamic> json) {
    return QueryTransactionResultResp(
      hash: json['hash'] as String,
      status: json['status'] as String,
      blockHeight: json['block_height'] as int,
      blockTimestamp: json['block_timestamp'] as int,
      confirmation: json['confirmation'] as int,
      msgs: (json['msgs'] as List<dynamic>? ?? <dynamic>[]).map((dynamic e) => Msg.fromJson(e as Map<String, dynamic>)).toList(),
      transactions: (json['transactions'] as List<dynamic>? ?? <dynamic>[]).map((dynamic e) => Transaction.fromJson(e as Map<String, dynamic>)).toList(),
      fees: (json['fees'] as List<dynamic>? ?? <dynamic>[]).map((dynamic e) => Fee.fromJson(e as Map<String, dynamic>)).toList(),
      gasWanted: json['gas_wanted'] as int,
      gasUsed: json['gas_used'] as int,
      memo: json['memo'] as String,
    );
  }
}
