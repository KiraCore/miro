import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/amount.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/msg.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/transaction.dart';

class QueryTransactionResultResp extends Equatable {
  final String hash;
  final String status;
  final int blockHeight;
  final int blockTimestamp;
  final int confirmation;
  final List<Msg> msgs;
  final List<Transaction> transactions;
  final List<Amount> fees;
  final int gasWanted;
  final int gasUsed;
  final String memo;

  const QueryTransactionResultResp({
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
      msgs: json['msgs'] != null
          ? List<Msg>.from(
              (json['msgs'] as List<dynamic>).map<Msg>((dynamic x) => Msg.fromJson(x as Map<String, dynamic>)))
          : List<Msg>.empty(),
      transactions: json['transactions'] != null
          ? List<Transaction>.from((json['transactions'] as List<dynamic>)
              .map<Transaction>((dynamic x) => Transaction.fromJson(x as Map<String, dynamic>)))
          : List<Transaction>.empty(),
      fees: json['fees'] != null
          ? List<Amount>.from(
              (json['fees'] as List<dynamic>).map<Amount>((dynamic x) => Amount.fromJson(x as Map<String, dynamic>)))
          : List<Amount>.empty(),
      gasWanted: json['gas_wanted'] as int,
      gasUsed: json['gas_used'] as int,
      memo: json['memo'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        hash,
        status,
        blockHeight,
        blockTimestamp,
        confirmation,
        msgs.hashCode,
        transactions.hashCode,
        fees.hashCode,
        gasWanted,
        gasUsed,
        memo,
      ];

  @override
  String toString() {
    return 'QueryTransactionResultResponse{hash: $hash, status: $status, blockHeight: $blockHeight, blockTimestamp: $blockTimestamp, confirmation: $confirmation, msgs: $msgs, transactions: $transactions, fees: $fees, gasWanted: $gasWanted, gasUsed: $gasUsed, memo: $memo}';
  }
}
