import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';

class ProposalModel extends AListItem {
  final int proposalId;
  final int votersCount;
  final int votesCount;
  final String description;
  final String execResult;
  final String metaData;
  final String minEnactmentEndBlockHeight;
  final String minVotingEndBlockHeight;
  final String proposer;
  final String quorum;
  final String title;
  final String transactionHash;
  final DateTime enactmentEndTime;
  final DateTime submitTime;
  final DateTime votingEndTime;
  final ProposalStatus proposalStatus;
  final AProposalTypeContentModel proposalTypeContentModel;
  bool _favourite = false;

  ProposalModel({
    required this.proposalId,
    required this.description,
    required this.execResult,
    required this.metaData,
    required this.minEnactmentEndBlockHeight,
    required this.minVotingEndBlockHeight,
    required this.proposer,
    required this.quorum,
    required this.proposalStatus,
    required this.title,
    required this.transactionHash,
    required this.votersCount,
    required this.votesCount,
    required this.enactmentEndTime,
    required this.submitTime,
    required this.votingEndTime,
    required this.proposalTypeContentModel,
  });

  @override
  String get cacheId => proposalId.toString();

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;
}
