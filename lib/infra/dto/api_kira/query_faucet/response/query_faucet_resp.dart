import 'package:equatable/equatable.dart';

class QueryFaucetResp extends Equatable {
  final String transactionHash;

  const QueryFaucetResp({required this.transactionHash});

  factory QueryFaucetResp.fromJson(Map<String, dynamic> json) {
    return QueryFaucetResp(
      transactionHash: json['hash'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[transactionHash];
}
