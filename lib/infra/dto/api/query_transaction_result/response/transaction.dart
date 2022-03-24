import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/amount.dart';

class Transaction extends Equatable {
  final String type;
  final String from;
  final String to;
  final List<Amount> amounts;

  const Transaction({
    required this.type,
    required this.from,
    required this.to,
    required this.amounts,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      amounts: (json['amounts'] as List<dynamic>)
          .map(
            (dynamic e) => Amount.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object> get props => <Object>[type, from, to, amounts.hashCode];

  @override
  String toString() {
    return 'Transaction{type: $type, from: $from, to: $to, amounts: $amounts}';
  }
}
