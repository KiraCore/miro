import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/response/fee.dart';

class QueryExecutionFeeResponse extends Equatable {
  final Fee fee;

  const QueryExecutionFeeResponse({
    required this.fee,
  });

  factory QueryExecutionFeeResponse.fromJson(Map<String, dynamic> json) {
    return QueryExecutionFeeResponse(
      fee: Fee.fromJson(json['fee'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[fee];
}
