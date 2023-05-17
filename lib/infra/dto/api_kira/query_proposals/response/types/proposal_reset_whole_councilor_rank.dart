import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalResetWholeCouncilorRank extends AProposalTypeContent {
  final String description;
  final String proposer;

  const ProposalResetWholeCouncilorRank({
    required String type,
    required this.description,
    required this.proposer,
  }) : super(type: type);

  factory ProposalResetWholeCouncilorRank.fromJson(Map<String, dynamic> json) {
    return ProposalResetWholeCouncilorRank(
      type: json['@type'] as String,
      description: json['description'] as String,
      proposer: json['proposer'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[description, proposer];
}
