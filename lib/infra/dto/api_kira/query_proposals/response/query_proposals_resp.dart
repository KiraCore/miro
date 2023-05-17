import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/proposal_pagination.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/proposal.dart';

class QueryProposalsResp extends Equatable {
  final List<Proposal> proposals;
  final ProposalPagination pagination;

  const QueryProposalsResp({
    required this.proposals,
    required this.pagination,
  });

  factory QueryProposalsResp.fromJson(Map<String, dynamic> json) {
    return QueryProposalsResp(
      proposals: (json['proposals'] as List<dynamic>).map((dynamic e) => Proposal.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: ProposalPagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => <Object>[proposals, pagination];
}
