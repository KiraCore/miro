import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposal/proposal.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/proposal_pagination.dart';

class GovernanceProposalsResp extends Equatable {
  final List<Proposal> proposals;
  final ProposalPagination pagination;

  const GovernanceProposalsResp({
    required this.proposals,
    required this.pagination,
  });

  factory GovernanceProposalsResp.fromJson(Map<String, dynamic> json) => GovernanceProposalsResp(
        proposals: (json['proposals'] as List<dynamic>).map((dynamic e) => Proposal.fromJson(e as Map<String, dynamic>)).toList(),
        pagination: ProposalPagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );

  @override
  List<Object> get props => <Object>[proposals, pagination];
}
