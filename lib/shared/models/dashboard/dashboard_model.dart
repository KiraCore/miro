import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
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

  factory DashboardModel.fromDto(DashboardResp dashboardResp) {
    return DashboardModel(
      consensusHealth: double.parse(dashboardResp.consensusHealth),
      currentBlockValidatorModel: CurrentBlockValidatorModel.fromDto(dashboardResp.currentBlockValidator),
      validatorsStatusModel: ValidatorsStatusModel.fromDto(dashboardResp.validators),
      blocksModel: BlocksModel.fromDto(dashboardResp.blocks),
      proposalsModel: ProposalsModel.fromDto(dashboardResp.proposals),
    );
  }

  String get consensusHealthPercentage => '${(consensusHealth * 100).round()}%';

  @override
  List<Object?> get props => <Object>[consensusHealth, currentBlockValidatorModel, validatorsStatusModel, blocksModel, proposalsModel];
}
