import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalMsgVote extends AProposalTypeContent {
  final String proposalId;
  final String voter;
  final String option;
  final String slash;

  const ProposalMsgVote({
    required String type,
    required this.proposalId,
    required this.voter,
    required this.option,
    required this.slash,
  }) : super(type: type);

  factory ProposalMsgVote.fromJson(Map<String, dynamic> json) {
    return ProposalMsgVote(
      type: json['@type'] as String,
      proposalId: json['proposal_id'] as String,
      voter: json['voter'] as String,
      option: json['option'] as String,
      slash: json['slash'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[proposalId, voter, option, slash];
}
