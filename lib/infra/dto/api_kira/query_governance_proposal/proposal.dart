import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class Proposal extends Equatable {
  final int proposalId;
  final String description;
  final String execResult;
  final String minEnactmentEndBlockHeight;
  final String minVotingEndBlockHeight;
  final String result;
  final String title;
  final DateTime enactmentEndTime;
  final DateTime submitTime;
  final DateTime votingEndTime;
  final AProposalTypeContent content;

  const Proposal({
    required this.proposalId,
    required this.description,
    required this.execResult,
    required this.minEnactmentEndBlockHeight,
    required this.minVotingEndBlockHeight,
    required this.result,
    required this.title,
    required this.enactmentEndTime,
    required this.submitTime,
    required this.votingEndTime,
    required this.content,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        proposalId: int.parse(json['proposal_id'] as String),
        description: json['description'] as String,
        execResult: json['exec_result'] as String,
        minEnactmentEndBlockHeight: json['min_enactment_end_block_height'] as String,
        minVotingEndBlockHeight: json['min_voting_end_block_height'] as String,
        result: json['result'] as String,
        title: json['title'] as String,
        enactmentEndTime: DateTime.parse(json['enactment_end_time'] as String),
        submitTime: DateTime.parse(json['submit_time'] as String),
        votingEndTime: DateTime.parse(json['voting_end_time'] as String),
        content: AProposalTypeContent.getProposalFromJson(json['content'] as Map<String, dynamic>),
      );

  @override
  List<Object> get props => <Object>[
        proposalId,
        description,
        execResult,
        minEnactmentEndBlockHeight,
        minVotingEndBlockHeight,
        enactmentEndTime,
        result,
        title,
        submitTime,
        votingEndTime,
        content,
      ];
}
