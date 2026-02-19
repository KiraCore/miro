import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
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

  final DashboardService dashboardService = globalLocator<DashboardService>();

  DashboardModel expectedDashboardModel = const DashboardModel(
    consensusHealth: 1,
    currentBlockValidatorModel: CurrentBlockValidatorModel(
        address: 'kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x', moniker: 'GENESIS VALIDATOR'),
    validatorsStatusModel: ValidatorsStatusModel(
      activeValidators: 1,
      inactiveValidators: 0,
      pausedValidators: 0,
      jailedValidators: 0,
      totalValidators: 1,
      waitingValidators: 0,
    ),
    blocksModel: BlocksModel(
      currentHeight: 108843,
      sinceGenesis: 106343,
      pendingTransactions: 0,
      currentTransactions: 0,
      latestTime: 5.0,
      averageTime: 5.0,
    ),
    proposalsModel:
        ProposalsModel(total: 0, active: 0, enacting: 0, finished: 0, successful: 0, proposers: 0, voters: 0),
  );

  group('Tests of DashboardService.getDashboardModel() method', () {
    // Mock infrastructure supports fetchQueryProposals, fetchQueryBlocks, and fetchDashboard.
    test('Should return [DashboardModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      DashboardModel actualDashboardModel = await dashboardService.getDashboardModel();

      // Assert
      expect(actualDashboardModel, expectedDashboardModel);
    });

    // TODO: Fix this test - invalid mock response structure doesn't trigger DioParseException
    // The mock returns {'invalid': 'response'} but the parsing doesn't fail as expected
    // Needs investigation of Dashboard DTO parsing logic with new Interx API structure
    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        dashboardService.getDashboardModel,
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        dashboardService.getDashboardModel,
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
