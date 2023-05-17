import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/validator_info.dart';

class Proposal extends Equatable {
  final int proposalId;
  final String title;
  final String result;
  final Map<String, dynamic> content;
  final DateTime votingEndTime;
  final ValidatorInfo proposerInfo;
  final String description;
  final String transactionHash;
  final int votersCount;
  final int votesCount;
  final String quorum;
  final DateTime submitTime;
  final DateTime enactmentEndTime;
  final String metaData;
  final String execResult;
  final String minEnactmentEndBlockHeight;
  final String minVotingEndBlockHeight;

  const Proposal({
    required this.proposalId,
    required this.title,
    required this.result,
    required this.content,
    required this.votingEndTime,
    required this.proposerInfo,
    required this.description,
    required this.transactionHash,
    required this.votersCount,
    required this.votesCount,
    required this.quorum,
    required this.submitTime,
    required this.enactmentEndTime,
    required this.metaData,
    required this.execResult,
    required this.minEnactmentEndBlockHeight,
    required this.minVotingEndBlockHeight,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      proposalId: int.parse(json['proposal_id'] as String),
      title: json['title'] as String,
      result: json['result'] as String,
      content: json['content'] as Map<String, dynamic>,
      votingEndTime: DateTime.parse(json['voting_end_time'] as String),
      proposerInfo: ValidatorInfo.fromJson(json['proposer_info'] as Map<String, dynamic>),
      description: json['description'] as String,
      transactionHash: json['transaction_hash'] as String,
      votersCount: json['voters_count'] as int,
      votesCount: json['votes_count'] as int,
      quorum: json['quorum'] as String,
      submitTime: DateTime.parse(json['submit_time'] as String),
      enactmentEndTime: DateTime.parse(json['enactment_end_time'] as String),
      metaData: json['meta_data'] as String,
      execResult: json['exec_result'] as String,
      minEnactmentEndBlockHeight: json['min_enactment_end_block_height'] as String,
      minVotingEndBlockHeight: json['min_voting_end_block_height'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        proposalId,
        title,
        result,
        content,
        votingEndTime,
        proposerInfo,
        description,
        transactionHash,
        votersCount,
        votesCount,
        quorum,
        submitTime,
        enactmentEndTime,
        metaData,
        execResult,
        minEnactmentEndBlockHeight,
        minVotingEndBlockHeight
      ];
}
