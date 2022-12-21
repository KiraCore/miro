import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/pagination.dart';

class QueryBalanceResp {
  final List<Balance> balances;
  final Pagination pagination;

  QueryBalanceResp({
    required this.balances,
    required this.pagination,
  });

  factory QueryBalanceResp.fromJson(Map<String, dynamic> json) => QueryBalanceResp(
        balances: json['balances'] == null
            ? List<Balance>.empty()
            : (json['balances'] as List<dynamic>)
                .map((dynamic e) => Balance.fromJson(e as Map<String, dynamic>))
                .toList(),
        pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );

  @override
  String toString(){
    return 'QueryBalanceResp{balances: ${balances.map((Balance e) => e.toString())}, pagination: $pagination}';
  }
}
