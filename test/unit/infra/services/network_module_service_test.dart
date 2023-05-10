import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/network_module_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();

  group('Tests of NetworkModuleService.getNetworkStatusModel()', () {
    test('Should return [NetworkHealthyModel] if [server HEALTHY]', () async {
      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        TestUtils.healthyNetworkUnknownModel,
      );

      // Assert
      NetworkHealthyModel expectedNetworkHealthyModel = TestUtils.networkHealthyModel;

      expect(actualNetworkStatusModel, expectedNetworkHealthyModel);
    });

    test('Should return [NetworkUnhealthyModel] if [server UNHEALTHY]', () async {
      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        TestUtils.unhealthyNetworkUnknownModel,
      );

      // Assert
      NetworkUnhealthyModel expectedNetworkUnhealthyModel = TestUtils.networkUnhealthyModel;

      expect(actualNetworkStatusModel, expectedNetworkUnhealthyModel);
    });

    test('Should return [NetworkOfflineModel] if [server OFFLINE]', () async {
      // Act
      ANetworkStatusModel actualNetworkStatusModel = await networkModuleService.getNetworkStatusModel(
        TestUtils.offlineNetworkUnknownModel,
      );

      // Assert
      NetworkOfflineModel expectedNetworkOfflineModel = TestUtils.networkOfflineModel;

      expect(actualNetworkStatusModel, expectedNetworkOfflineModel);
    });
  });
}
