import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/shared/models/dashboard/current_block_validator_model.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/models/dashboard/proposals_model.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';

void main() {
  CurrentBlockValidatorModel actualCurrentBlockValidatorModel = const CurrentBlockValidatorModel(
    address: 'kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x',
    moniker: 'GENESIS VALIDATOR',
  );

  ValidatorsStatusModel actualValidatorsStatusModel = const ValidatorsStatusModel(
    activeValidators: 97,
    inactiveValidators: 426,
    pausedValidators: 30,
    //
    jailedValidators: 8,
    totalValidators: 561,
    waitingValidators: 419,
  );

  BlocksModel actualBlocksModel = const BlocksModel(
    currentHeight: 89629,
    sinceGenesis: 89628,
    pendingTransactions: 0,
    currentTransactions: 0,
    latestTime: 5.009137321,
    averageTime: 5.009582592,
  );

  ProposalsModel actualProposalsModel = const ProposalsModel(
    total: 2,
    active: 2,
    enacting: 0,
    finished: 0,
    successful: 0,
    proposers: '1',
    voters: '1',
  );

  group('Tests of DashboardModel.consensusHealthPercentage getter', () {
    test('Should parse 0.4 number into "40%" ', () {
      // Arrange
      DashboardModel actualDashboardModel = DashboardModel(
        consensusHealth: 0.4,
        currentBlockValidatorModel: actualCurrentBlockValidatorModel,
        validatorsStatusModel: actualValidatorsStatusModel,
        blocksModel: actualBlocksModel,
        proposalsModel: actualProposalsModel,
      );

      // Arrange
      expect(actualDashboardModel.consensusHealthPercentage, '40%');
    });

    test('Should parse 0 number into "0%" ', () {
      // Arrange
      DashboardModel actualDashboardModel = DashboardModel(
        consensusHealth: 0,
        currentBlockValidatorModel: actualCurrentBlockValidatorModel,
        validatorsStatusModel: actualValidatorsStatusModel,
        blocksModel: actualBlocksModel,
        proposalsModel: actualProposalsModel,
      );

      // Arrange
      expect(actualDashboardModel.consensusHealthPercentage, '0%');
    });

    test('Should parse 1 number into "100%" ', () {
      // Arrange
      DashboardModel actualDashboardModel = DashboardModel(
        consensusHealth: 1,
        currentBlockValidatorModel: actualCurrentBlockValidatorModel,
        validatorsStatusModel: actualValidatorsStatusModel,
        blocksModel: actualBlocksModel,
        proposalsModel: actualProposalsModel,
      );

      // Arrange
      expect(actualDashboardModel.consensusHealthPercentage, '100%');
    });

    test('Should parse 1.5 number into "150%" ', () {
      // Arrange
      DashboardModel actualDashboardModel = DashboardModel(
        consensusHealth: 1.5,
        currentBlockValidatorModel: actualCurrentBlockValidatorModel,
        validatorsStatusModel: actualValidatorsStatusModel,
        blocksModel: actualBlocksModel,
        proposalsModel: actualProposalsModel,
      );

      // Arrange
      expect(actualDashboardModel.consensusHealthPercentage, '150%');
    });

    test('Should parse -0.5 number into "-50%" ', () {
      // Arrange
      DashboardModel actualDashboardModel = DashboardModel(
        consensusHealth: -0.5,
        currentBlockValidatorModel: actualCurrentBlockValidatorModel,
        validatorsStatusModel: actualValidatorsStatusModel,
        blocksModel: actualBlocksModel,
        proposalsModel: actualProposalsModel,
      );

      // Arrange
      expect(actualDashboardModel.consensusHealthPercentage, '-50%');
    });
  });
}
