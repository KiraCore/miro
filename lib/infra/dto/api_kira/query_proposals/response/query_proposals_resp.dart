import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/proposal.dart';

class QueryProposalsResp extends Equatable {
  final List<Proposal> proposals;
  final int totalCount;

  const QueryProposalsResp({
    required this.proposals,
    required this.totalCount,
  });

  factory QueryProposalsResp.fromJson(Map<String, dynamic> json) {
    return QueryProposalsResp(
      proposals: (json['proposals'] as List<dynamic>).map((dynamic e) => Proposal.fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: json['total_count'] as int,
    );
  }

  @override
  List<Object> get props => <Object>[proposals, totalCount];
}
