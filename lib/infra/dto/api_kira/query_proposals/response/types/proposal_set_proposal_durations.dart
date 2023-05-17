import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalSetProposalDurations extends AProposalTypeContent {
  final List<String> proposalDurations;
  final List<String> typeOfProposals;

  const ProposalSetProposalDurations({
    required String type,
    required this.proposalDurations,
    required this.typeOfProposals,
  }) : super(type: type);

  factory ProposalSetProposalDurations.fromJson(Map<String, dynamic> json) {
    return ProposalSetProposalDurations(
      type: json['@type'] as String,
      proposalDurations: (json['proposalDurations'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      typeOfProposals: (json['typeofProposals'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  List<Object> get props => <Object>[proposalDurations, typeOfProposals];
}
