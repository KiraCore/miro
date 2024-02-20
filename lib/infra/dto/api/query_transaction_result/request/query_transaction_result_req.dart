import 'package:equatable/equatable.dart';

class QueryTransactionResultReq extends Equatable {
  /// This is an option of a transaction hash
  final String txHash;

  const QueryTransactionResultReq({
    required this.txHash,
  });

  @override
  List<Object?> get props => <Object>[txHash];
}
