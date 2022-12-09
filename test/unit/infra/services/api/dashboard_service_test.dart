import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/shared/models/dashboard/current_block_validator_model.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/models/dashboard/proposals_model.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/dashboard_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final DashboardService dashboardService = globalLocator<DashboardService>();

  DashboardModel expectedDashboardModel = const DashboardModel(
    consensusHealth: 1,
    currentBlockValidatorModel: CurrentBlockValidatorModel(
      address: 'kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x',
      moniker: 'GENESIS VALIDATOR',
    ),
    validatorsStatusModel: ValidatorsStatusModel(
      activeValidators: 1,
      inactiveValidators: 0,
      pausedValidators: 0,
      jailedValidators: 0,
      totalValidators: 1,
      waitingValidators: 0,
    ),
    blocksModel: BlocksModel(
      currentHeight: 89629,
      sinceGenesis: 89628,
      pendingTransactions: 0,
      currentTransactions: 0,
      latestTime: 5.009137321,
      averageTime: 5.009582592,
    ),
    proposalsModel: ProposalsModel(
      total: 0,
      active: 0,
      enacting: 0,
      finished: 0,
      successful: 0,
      proposers: '1',
      voters: '1',
    ),
  );

  group('Tests of getDashboardModel() method', () {
    test('Should return DashboardModel', () async {
      // Act
      DashboardModel actualDashboardModel = await dashboardService.getDashboardModel();

      // Assert
      expect(actualDashboardModel, expectedDashboardModel);
    });
  });
}
