import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/dto/api/query_blocks/response/query_blocks_resp.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_proposals/response/query_proposals_resp.dart';
import 'package:miro/infra/dto/shared/vote_result.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/shared/models/dashboard/current_block_validator_model.dart';
import 'package:miro/shared/models/dashboard/proposals_model.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';

class DashboardModel extends Equatable {
  final double consensusHealth;
  final CurrentBlockValidatorModel currentBlockValidatorModel;
  final ValidatorsStatusModel validatorsStatusModel;
  final BlocksModel blocksModel;
  final ProposalsModel proposalsModel;

  const DashboardModel({
    required this.consensusHealth,
    required this.currentBlockValidatorModel,
    required this.validatorsStatusModel,
    required this.blocksModel,
    required this.proposalsModel,
  });

  /// Creates a DashboardModel from all required API responses.
  /// All parsing logic is consolidated here instead of in the service.
  factory DashboardModel.fromResponses({
    required DashboardResp dashboardResp,
    required QueryProposalsResp proposalsResp,
    required QueryBlocksResp blocksResp,
    required QueryInterxStatusResp statusResp,
  }) {
    // Parse current block validator from dashboard response
    final CurrentBlockValidatorModel currentBlockValidatorModel = _parseCurrentBlockValidator(dashboardResp);

    // Parse validators status from dashboard response
    final ValidatorsStatusModel validatorsStatusModel = _parseValidatorsStatus(dashboardResp);

    // Parse proposals statistics
    final ProposalsModel proposalsModel = _parseProposals(proposalsResp);

    // Parse blocks model
    final BlocksModel blocksModel = _parseBlocks(blocksResp, statusResp);

    return DashboardModel(
      consensusHealth: 1,
      currentBlockValidatorModel: currentBlockValidatorModel,
      validatorsStatusModel: validatorsStatusModel,
      blocksModel: blocksModel,
      proposalsModel: proposalsModel,
    );
  }

  static CurrentBlockValidatorModel _parseCurrentBlockValidator(DashboardResp dashboardResp) {
    if (dashboardResp.validators.isNotEmpty) {
      final DashboardValidator firstValidator = dashboardResp.validators.first;
      return CurrentBlockValidatorModel(
        address: firstValidator.address,
        moniker: firstValidator.moniker,
      );
    }
    return const CurrentBlockValidatorModel(
      address: '',
      moniker: '',
    );
  }

  static ValidatorsStatusModel _parseValidatorsStatus(DashboardResp dashboardResp) {
    return ValidatorsStatusModel(
      activeValidators: dashboardResp.status.activeValidators,
      pausedValidators: dashboardResp.status.pausedValidators,
      inactiveValidators: dashboardResp.status.inactiveValidators,
      jailedValidators: dashboardResp.status.jailedValidators,
      totalValidators: dashboardResp.status.totalValidators,
      waitingValidators: dashboardResp.status.waitingValidators,
    );
  }

  static ProposalsModel _parseProposals(QueryProposalsResp proposalsResp) {
    int total = proposalsResp.proposals.length;
    int active = proposalsResp.proposals.where((ProposalModel p) => p.result == VoteResult.pending.value).length;
    int enacting = proposalsResp.proposals.where((ProposalModel p) => p.result == VoteResult.enactment.value).length;
    int finished = proposalsResp.proposals
        .where((ProposalModel p) =>
            p.result == VoteResult.passed.value ||
            p.result == VoteResult.rejected.value ||
            p.result == VoteResult.rejectedWithVeto.value ||
            p.result == VoteResult.quorumNotReached.value ||
            p.result == VoteResult.passedWithExecFail.value ||
            p.result == VoteResult.enactment.value)
        .length;
    int successful = proposalsResp.proposals
        .where((ProposalModel p) => p.result == VoteResult.passed.value || p.result == VoteResult.enactment.value)
        .length;

    List<ProposalModel> proposals = proposalsResp.proposals;
    int voters = 0;
    for (ProposalModel proposal in proposals) {
      voters += proposal.votersCount;
    }

    return ProposalsModel(
      total: total,
      active: active,
      enacting: enacting,
      finished: finished,
      successful: successful,
      proposers: proposals.length,
      voters: voters,
    );
  }

  static BlocksModel _parseBlocks(QueryBlocksResp blocksResp, QueryInterxStatusResp statusResp) {
    double latestTime = 0;
    if (blocksResp.blocks.length >= 2) {
      latestTime = (blocksResp.blocks.first.header.time.millisecondsSinceEpoch -
              blocksResp.blocks.last.header.time.millisecondsSinceEpoch) /
          1000;
    }

    return BlocksModel(
      currentHeight: statusResp.syncInfo.latestBlockHeight,
      sinceGenesis: statusResp.syncInfo.latestBlockHeight - statusResp.syncInfo.earliestBlockHeight,
      // TODO: #27
      pendingTransactions: 0,
      currentTransactions: 0,
      latestTime: latestTime,
      averageTime: latestTime,
    );
  }

  String get consensusHealthPercentage => '${(consensusHealth * 100).round()}%';

  @override
  List<Object?> get props =>
      <Object>[consensusHealth, currentBlockValidatorModel, validatorsStatusModel, blocksModel, proposalsModel];
}
