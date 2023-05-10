import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/loading_page_cubit.dart';
import 'package:miro/blocs/pages/loading/loading_page/loading_page_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_connected_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_connecting_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_disconnected_state.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_empty_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/loading/loading_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of [LoadingPage] process: Connecting with healthy network', () {
    test('Should emit LoadingPageConnectedState if network is healthy', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = NetworkModuleBloc();
      LoadingPageCubit actualLoadingPageCubit = LoadingPageCubit(
        networkModuleBloc: actualNetworkModuleBloc,
      );
      // Complete loadingCompleter to avoid waiting for timer to end
      actualLoadingPageCubit.loadingTimerController.loadingCompleter.complete();

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() as an initial NetworkModuleBloc state');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      ALoadingPageState expectedLoadingPageState = const LoadingPageConnectingState();

      TestUtils.printInfo('Should return LoadingPageConnectingState() as an initial LoadingPageCubit state');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(TestUtils.healthyNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState.connecting() with NetworkUnknownModel for healthy network');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageConnectingState(
        networkStatusModel: TestUtils.healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return LoadingPageConnectingState() with NetworkUnknownModel for healthy network');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(
        TestUtils.networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo('Should return NetworkModuleState.connected() with NetworkHealthyModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageConnectedState(
        networkStatusModel: TestUtils.networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo('Should return LoadingPageConnectedState() with NetworkHealthyModel');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);
    });
  });

  group('Tests of [LoadingPage] process: Connecting with unhealthy network', () {
    test('Should emit LoadingPageDisconnectedState if network is unhealthy', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = NetworkModuleBloc();
      LoadingPageCubit actualLoadingPageCubit = LoadingPageCubit(
        networkModuleBloc: actualNetworkModuleBloc,
      );
      // Complete loadingCompleter to avoid waiting for timer to end
      actualLoadingPageCubit.loadingTimerController.loadingCompleter.complete();

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() as an initial NetworkModuleBloc state');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      ALoadingPageState expectedLoadingPageState = const LoadingPageConnectingState();

      TestUtils.printInfo('Should return LoadingPageConnectingState() as an initial LoadingPageCubit state');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.unhealthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(TestUtils.unhealthyNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState.connecting() with NetworkUnknownModel for unhealthy network');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageConnectingState(
        networkStatusModel: TestUtils.unhealthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return LoadingPageConnectingState() with NetworkUnknownModel for unhealthy network');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() if network is unhealthy');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageDisconnectedState(
        networkStatusModel: TestUtils.networkUnhealthyModel,
        connectionErrorType: ConnectionErrorType.serverUnhealthy,
      );

      TestUtils.printInfo('Should return LoadingPageDisconnectedState() with NetworkUnhealthyModel');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);
    });
  });

  group('Tests of [LoadingPage] process: Connecting with offline network', () {
    test('Should emit LoadingPageDisconnectedState if network is offline', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = NetworkModuleBloc();
      LoadingPageCubit actualLoadingPageCubit = LoadingPageCubit(
        networkModuleBloc: actualNetworkModuleBloc,
      );
      // Complete loadingCompleter to avoid waiting for timer to end
      actualLoadingPageCubit.loadingTimerController.loadingCompleter.complete();

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() as an initial NetworkModuleBloc state');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      ALoadingPageState expectedLoadingPageState = const LoadingPageConnectingState();

      TestUtils.printInfo('Should return LoadingPageConnectingState() as an initial LoadingPageCubit state');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(TestUtils.offlineNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState.connecting() with NetworkUnknownModel for offline network');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageConnectingState(
        networkStatusModel: TestUtils.offlineNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return LoadingPageConnectingState() with NetworkUnknownModel for offline network');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() if network is offline');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageDisconnectedState(
        networkStatusModel: TestUtils.networkOfflineModel,
        connectionErrorType: ConnectionErrorType.serverOffline,
      );

      TestUtils.printInfo('Should return LoadingPageDisconnectedState() with NetworkOfflineModel');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);
    });
  });

  group('Tests of [LoadingPage] process: Canceling connection with network', () {
    test('Should emit LoadingPageDisconnectedState if network connection is canceled', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = NetworkModuleBloc();
      LoadingPageCubit actualLoadingPageCubit = LoadingPageCubit(
        networkModuleBloc: actualNetworkModuleBloc,
      );
      // Complete loadingCompleter to avoid waiting for timer to end
      actualLoadingPageCubit.loadingTimerController.loadingCompleter.complete();

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() as an initial NetworkModuleBloc state');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      ALoadingPageState expectedLoadingPageState = const LoadingPageConnectingState();

      TestUtils.printInfo('Should return LoadingPageConnectingState() as an initial LoadingPageCubit state');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(TestUtils.healthyNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState.connecting() with NetworkUnknownModel for healthy network');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageConnectingState(
        networkStatusModel: TestUtils.healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return LoadingPageConnectingState() with NetworkUnknownModel for healthy network');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);

      // ************************************************************************************************

      // Act
      actualLoadingPageCubit.cancelConnection();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState.disconnected() if connection is canceled');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // Assert
      expectedLoadingPageState = LoadingPageDisconnectedState(
        networkStatusModel: NetworkEmptyModel(connectionStatusType: ConnectionStatusType.disconnected),
        connectionErrorType: ConnectionErrorType.canceledByUser,
      );

      TestUtils.printInfo('Should return LoadingPageDisconnectedState() with NetworkEmptyModel if connection is canceled');
      expect(actualLoadingPageCubit.state, expectedLoadingPageState);
    });
  });
}
