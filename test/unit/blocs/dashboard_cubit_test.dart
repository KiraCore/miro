import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/dashboard/a_dashboard_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/dashboard_cubit.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_error_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_loading_state.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/shared/models/dashboard/current_block_validator_model.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/models/dashboard/proposals_model.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/dashboard_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  DashboardModel expectedDashboardModel = const DashboardModel(
    consensusHealth: 1,
    currentBlockValidatorModel: CurrentBlockValidatorModel(
      moniker: 'GENESIS VALIDATOR',
      address: 'kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x',
    ),
    validatorsStatusModel: ValidatorsStatusModel(
      activeValidators: 1,
      totalValidators: 1,
      pausedValidators: 0,
      inactiveValidators: 0,
      jailedValidators: 0,
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
      proposers: '1',
      voters: '1',
      total: 0,
      active: 0,
      successful: 0,
      finished: 0,
      enacting: 0,
    ),
  );

  group('Tests of [DashboardCubit] process', () {
    test('Should return ADashboardState consistent with network response', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>()..add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      DashboardCubit actualDashboardCubit = DashboardCubit();

      // Assert
      ADashboardState expectedDashboardState = DashboardLoadingState();

      TestUtils.printInfo('Should return DashboardLoadingState as a initial state');
      expect(actualDashboardCubit.state, expectedDashboardState);

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected() with network offline model');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedDashboardState = DashboardErrorState();

      TestUtils.printInfo('Should return DashboardErrorState if cannot fetch dashboard data');
      expect(actualDashboardCubit.state, expectedDashboardState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleConnectEvent(TestUtils.networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedDashboardState = DashboardLoadedState(dashboardModel: expectedDashboardModel);

      TestUtils.printInfo('Should return DashboardErrorState if cannot fetch dashboard data');
      expect(actualDashboardCubit.state, expectedDashboardState);
    });
  });
}
