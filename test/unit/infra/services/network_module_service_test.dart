import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/mock_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/network_module_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();

  group('Tests of getNetworkStatusModel()', () {
    test('Should return NetworkUnhealthyModel', () async {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        uri: Uri.parse('https://unhealthy.kira.network'),
        connectionStatusType: ConnectionStatusType.disconnected,
      );

      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        networkUnknownModel,
      );

      // Assert
      NetworkUnhealthyModel expectedNetworkUnhealthyModel = NetworkUnhealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://unhealthy.kira.network'),
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

      expect(
        actualNetworkStatusModel,
        expectedNetworkUnhealthyModel,
      );
    });

    test('Should return NetworkHealthyModel', () async {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://healthy.kira.network'),
      );

      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        networkUnknownModel,
      );

      // Assert
      NetworkHealthyModel expectedNetworkHealthyModel = NetworkHealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://healthy.kira.network'),
        networkInfoModel: NetworkInfoModel(
          chainId: 'localnet-1',
          interxVersion: 'v0.4.20-rc2',
          latestBlockHeight: 108843,
          latestBlockTime: DateTime.now(),
          activeValidators: 319,
          totalValidators: 475,
        ),
      );

      expect(
        actualNetworkStatusModel,
        expectedNetworkHealthyModel,
      );
    });

    test('Should return NetworkOfflineModel', () async {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://offline.kira.network'),
      );

      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        networkUnknownModel,
      );

      // Assert
      NetworkOfflineModel expectedNetworkOfflineModel = NetworkOfflineModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://offline.kira.network'),
      );

      expect(
        actualNetworkStatusModel,
        expectedNetworkOfflineModel,
      );
    });
  });
}
