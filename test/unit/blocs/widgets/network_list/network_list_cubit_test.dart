import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_list/a_network_list_state.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/widgets/network_list/network_list/states/network_list_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/network_list/network_list_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  List<NetworkUnknownModel> networkUnknownModelList = <NetworkUnknownModel>[
    TestUtils.unhealthyNetworkUnknownModel,
    TestUtils.healthyNetworkUnknownModel,
    TestUtils.offlineNetworkUnknownModel,
  ];

  group('Tests of [NetworkListCubit] process', () {
    test('Should return NetworkUnknownModel list, then update their status amd update connected network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
      NetworkListCubit actualNetworkListCubit = globalLocator<NetworkListCubit>();

      // Assert
      ANetworkListState expectedNetworkListState = NetworkListLoadingState();

      TestUtils.printInfo('Should return NetworkListLoadingState');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkListCubit.initNetworkStatusModelList();

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: networkUnknownModelList);

      TestUtils.printInfo('Should return NetworkListLoadedState containing NetworkUnknownModel list with disconnected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkModuleBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: <ANetworkStatusModel>[
        TestUtils.networkUnhealthyModel,
        TestUtils.networkHealthyModel,
        TestUtils.initialNetworkOfflineModel,
      ]);

      TestUtils.printInfo('Should return NetworkListLoadedState containing ANetworkStatusModels list with disconnected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkListCubit.setNetworkStatusModel(
        networkStatusModel: TestUtils.networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: <ANetworkStatusModel>[
        TestUtils.networkUnhealthyModel,
        TestUtils.networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        TestUtils.initialNetworkOfflineModel,
      ]);

      TestUtils.printInfo(
          'Should return NetworkListLoadedState containing ANetworkStatusModels list with two disconnected status and one with connected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );
    });
  });
}
