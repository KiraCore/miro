import 'package:equatable/equatable.dart';

class QueryTransactionResultReq extends Equatable {
  final String txHash;

  const QueryTransactionResultReq({
    required this.txHash,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'txHash': txHash,
    };
  }

  @override
  List<Object> get props => <Object>[txHash];

  @override
  String toString() {
    return 'QueryTransactionResultRequest{txHash: $txHash}';
  }
}
