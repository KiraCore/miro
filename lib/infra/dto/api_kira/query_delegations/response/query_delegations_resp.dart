import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/response/delegation.dart';
import 'package:miro/infra/dto/shared/pagination.dart';

class QueryDelegationsResp extends Equatable {
  final List<Delegation> delegations;
  final Pagination pagination;

  const QueryDelegationsResp({
    required this.delegations,
    required this.pagination,
  });

  factory QueryDelegationsResp.fromJson(Map<String, dynamic> json) {
    return QueryDelegationsResp(
      delegations: (json['delegations'] as List<dynamic>).map((dynamic e) => Delegation.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[delegations, pagination];
}
