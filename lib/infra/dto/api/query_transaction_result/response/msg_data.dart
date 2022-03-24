import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/amount.dart';

class MsgData extends Equatable {
  final String fromAddress;
  final String toAddress;
  final List<Amount> amount;

  const MsgData({
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
  });

  factory MsgData.fromJson(Map<String, dynamic> json) {
    return MsgData(
      fromAddress: json['from_address'] as String,
      toAddress: json['to_address'] as String,
      amount: (json['amount'] as List<dynamic>).map((dynamic e) => Amount.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object> get props => <Object>[fromAddress, toAddress, amount.hashCode];

  @override
  String toString() {
    return 'MsgData{fromAddress: $fromAddress, toAddress: $toAddress, amount: $amount}';
  }
}
