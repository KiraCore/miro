import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposal/proposal.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposal/vote.dart';

class GovernanceProposalResp extends Equatable {
  final Proposal proposal;
  final List<Vote> votes;

  const GovernanceProposalResp({
    required this.proposal,
    required this.votes,
  });

  factory GovernanceProposalResp.fromJson(Map<String, dynamic> json) {
    return GovernanceProposalResp(
      proposal: Proposal.fromJson(json['proposal'] as Map<String, dynamic>),
      votes: (json['votes'] as List<dynamic>).map((dynamic e) => Vote.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object> get props => <Object>[proposal, votes];
}
