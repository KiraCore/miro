import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loading_state.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_list_cubit_test.dart --platform chrome
Future<void> main() async {
  await initTestLocator();

  List<NetworkUnknownModel> networkUnknownModelList = <NetworkUnknownModel>[
    NetworkUnknownModel(
      uri: Uri.parse('https://unhealthy.kira.network'),
      name: 'unhealthy-mainnet',
      connectionStatusType: ConnectionStatusType.disconnected,
    ),
    NetworkUnknownModel(
      uri: Uri.parse('https://healthy.kira.network'),
      name: 'healthy-mainnet',
      connectionStatusType: ConnectionStatusType.disconnected,
    ),
    NetworkUnknownModel(
      uri: Uri.parse('https://offline.kira.network'),
      name: 'offline-mainnet',
      connectionStatusType: ConnectionStatusType.disconnected,
    ),
  ];

  NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04 12:42:54.395Z'),
    ),
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.11',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
    ),
  );

  NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
  );

  group('Tests of NetworkListCubit setup networks process', () {
    test('Should return NetworkUnknownModel list, then update their status amd update connected network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = NetworkModuleBloc();
      NetworkListCubit actualNetworkListCubit = actualNetworkModuleBloc.networkListCubit;

      // Assert
      ANetworkListState expectedNetworkListState = NetworkListLoadingState();

      testPrint('Should return NetworkListLoadingState');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkListCubit.initNetworkStatusModelList();

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: networkUnknownModelList);

      testPrint('Should return NetworkListLoadedState containing NetworkUnknownModel list with disconnected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkModuleBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: <ANetworkStatusModel>[
        networkUnhealthyModel,
        networkHealthyModel,
        networkOfflineModel,
      ]);

      testPrint('Should return NetworkListLoadedState containing ANetworkStatusModels list with disconnected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      actualNetworkListCubit.setNetworkStatusModel(
        networkStatusModel: networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModelList: <ANetworkStatusModel>[
        networkUnhealthyModel,
        networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        networkOfflineModel,
      ]);

      testPrint(
          'Should return NetworkListLoadedState containing ANetworkStatusModels list with two disconnected status and one with connected status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );
    });
  });
}
