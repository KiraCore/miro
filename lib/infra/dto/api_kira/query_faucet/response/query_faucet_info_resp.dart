import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';

class QueryFaucetInfoResp extends Equatable {
  final String address;
  final List<Balance> balances;

  const QueryFaucetInfoResp({
    required this.address,
    required this.balances,
  });

  factory QueryFaucetInfoResp.fromJson(Map<String, dynamic> json) {
    List<dynamic> balancesList = json['balances'] as List<dynamic>;
    return QueryFaucetInfoResp(
      address: json['address'] as String,
      balances: balancesList.map((dynamic e) => Balance.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[address, balances];
}
