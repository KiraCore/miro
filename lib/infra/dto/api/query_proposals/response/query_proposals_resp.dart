import 'package:equatable/equatable.dart';

class QueryProposalsResp extends Equatable {
  final List<ProposalModel> proposals;

  const QueryProposalsResp({
    required this.proposals,
  });

  factory QueryProposalsResp.fromJson(List<dynamic> json) {
    return QueryProposalsResp(
      proposals: json.map((dynamic e) => ProposalModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[proposals];
}

class ProposalModel extends Equatable {
  final String proposalId;
  final String title;
  final String description;
  final Map<String, dynamic> content;
  final String submitTime;
  final String votingEndTime;
  final String enactmentEndTime;
  final String minVotingEndBlockHeight;
  final String minEnactmentEndBlockHeight;
  final String execResult;
  final String result;
  final int votersCount;
  final int votesCount;
  final String quorum;
  final String metaData;

  const ProposalModel({
    required this.proposalId,
    required this.title,
    required this.description,
    required this.content,
    required this.submitTime,
    required this.votingEndTime,
    required this.enactmentEndTime,
    required this.minVotingEndBlockHeight,
    required this.minEnactmentEndBlockHeight,
    required this.execResult,
    required this.result,
    required this.votersCount,
    required this.votesCount,
    required this.quorum,
    required this.metaData,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    return ProposalModel(
      proposalId: json['proposalId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      content: json['content'] as Map<String, dynamic>? ?? <String, dynamic>{},
      submitTime: json['submitTime'] as String? ?? '',
      votingEndTime: json['votingEndTime'] as String? ?? '',
      enactmentEndTime: json['enactmentEndTime'] as String? ?? '',
      minVotingEndBlockHeight: json['minVotingEndBlockHeight'] as String? ?? '',
      minEnactmentEndBlockHeight: json['minEnactmentEndBlockHeight'] as String? ?? '',
      execResult: json['execResult'] as String? ?? '',
      result: json['result'] as String? ?? '',
      votersCount: json['voters_count'] is String
          ? int.tryParse(json['voters_count'] as String) ?? 0
          : json['voters_count'] as int? ?? 0,
      votesCount: json['votes_count'] is String
          ? int.tryParse(json['votes_count'] as String) ?? 0
          : json['votes_count'] as int? ?? 0,
      quorum: json['quorum'] as String? ?? '',
      metaData: json['meta_data'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => <Object?>[
        proposalId,
        title,
        description,
        content,
        submitTime,
        votingEndTime,
        enactmentEndTime,
        minVotingEndBlockHeight,
        minEnactmentEndBlockHeight,
        execResult,
        result,
        votersCount,
        votesCount,
        quorum,
        metaData,
      ];
}
