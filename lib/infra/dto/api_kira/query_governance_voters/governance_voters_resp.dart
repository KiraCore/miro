import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters.dart';

class GovernanceProposalVotersResp extends Equatable {
  final List<Voters> voter;

  const GovernanceProposalVotersResp({required this.voter});

  factory GovernanceProposalVotersResp.fromJsonList(List<dynamic> jsonList) {
    return GovernanceProposalVotersResp(
      voter: jsonList.map((dynamic e) => Voters.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object> get props => <Object>[voter];
}
