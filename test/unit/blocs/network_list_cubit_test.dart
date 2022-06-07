import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loading_state.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_list_cubit_test.dart --platform chrome
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await initTestLocator();

  group('Tests of NetworkListCubit initial state', () {
    test('Should return NetworkListLoadingState', () async {
      // Arrange
      NetworkListCubit actualNetworkListCubit = NetworkListCubit();

      // Assert
      ANetworkListState expectedNetworkListState = NetworkListLoadingState();
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );
    });
  });

  group('Tests of NetworkListCubit setup networks process', () {
    test('Should return NetworkUnknownModels, fetch network status and create NetworkStatusModels with correct status',
        () async {
      // Arrange
      NetworkListCubit actualNetworkListCubit = NetworkListCubit();

      // Assert
      ANetworkListState expectedNetworkListState = NetworkListLoadingState();

      testPrint('Should return NetworkListLoadingState');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      await actualNetworkListCubit.initNetworks();

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModels: <ANetworkStatusModel>[
        NetworkUnknownModel(uri: Uri.parse('https://healthy.kira.network/')),
        NetworkUnknownModel(uri: Uri.parse('https://online.kira.network/')),
        NetworkUnknownModel(uri: Uri.parse('https://offline.kira.network/'))
      ]);

      testPrint('Should return NetworkListLoadedState with list containing NetworkUnknownModels only');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedNetworkListState = NetworkListLoadedState(networkStatusModels: <ANetworkStatusModel>[
        NetworkHealthyModel(
          uri: Uri.parse('https://healthy.kira.network/'),
          networkInfoModel: NetworkInfoModel(
            chainId: 'localnet-1',
            latestBlockHeight: 108843,
            latestBlockTime: DateTime.now(),
          ),
        ),
        NetworkUnhealthyModel(
          uri: Uri.parse('https://online.kira.network/'),
          interxErrors: const <InterxError>[InterxError.versionOutdated, InterxError.blockTimeOutdated],
          networkInfoModel: NetworkInfoModel(
            chainId: 'testnet-7',
            latestBlockHeight: 108843,
            latestBlockTime: DateTime.parse('2021-11-04 12:42:54.395Z'),
          ),
        ),
        NetworkOfflineModel(uri: Uri.parse('https://offline.kira.network/'))
      ]);

      testPrint('Should return NetworkListLoadedState with list containing ANetworkStatusModels with assigned status');
      expect(
        actualNetworkListCubit.state,
        expectedNetworkListState,
      );
    });
  });
}
