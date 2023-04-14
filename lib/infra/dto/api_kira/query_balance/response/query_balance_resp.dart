import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/pagination.dart';

class QueryBalanceResp extends Equatable {
  final List<Balance> balances;
  final Pagination pagination;

  const QueryBalanceResp({
    required this.balances,
    required this.pagination,
  });

  factory QueryBalanceResp.fromJson(Map<String, dynamic> json) {
    List<dynamic> balancesList = json['balances'] != null ? json['balances'] as List<dynamic> : List<dynamic>.empty();

    return QueryBalanceResp(
      balances: balancesList.map((dynamic e) => Balance.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[balances, pagination];
}
