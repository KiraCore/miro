import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_votes/votes.dart';

class GovernanceProposalVotesResp extends Equatable {
  final List<Votes> votes;

  const GovernanceProposalVotesResp({required this.votes});

  factory GovernanceProposalVotesResp.fromJsonList(List<dynamic> jsonList) {
    return GovernanceProposalVotesResp(
      votes: jsonList.map((dynamic e) => Votes.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
  @override
  List<Object> get props => <Object>[votes];
}
