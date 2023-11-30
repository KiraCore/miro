import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/response/undelegation.dart';
import 'package:miro/infra/dto/shared/pagination.dart';

class QueryUndelegationsResp extends Equatable {
  final List<Undelegation> undelegations;
  final Pagination pagination;

  const QueryUndelegationsResp({
    required this.undelegations,
    required this.pagination,
  });

  factory QueryUndelegationsResp.fromJson(Map<String, dynamic> json) {
    List<dynamic> undelegations = (json['undelegations'] as List<dynamic>?) ?? List<dynamic>.empty();
    return QueryUndelegationsResp(
      undelegations: undelegations.map((dynamic e) => Undelegation.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[undelegations, pagination];
}
