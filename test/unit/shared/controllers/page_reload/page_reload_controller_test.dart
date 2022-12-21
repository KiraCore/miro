import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/page_reload/page_reload_controller_test.dart --platform chrome --null-assertions
void main() {
  NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
    ),
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.22',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
    ),
  );

  group('Tests of PageReloadController process for PageReloadConditionType.differentNetwork', () {
    test('Should return values assigned to specified actions', () {
      // Arrange
      PageReloadController actualPageReloadController = PageReloadController();

      // Assert
      TestUtils.printInfo('Should return "0" as initial value of activeReloadId');
      expect(actualPageReloadController.activeReloadId, 0);

      // Assert
      TestUtils.printInfo('Should return "true" if reloadId is active');
      expect(actualPageReloadController.canReloadComplete(0), true);

      // Assert
      TestUtils.printInfo('Should return "true" if initial network is not set');
      expect(actualPageReloadController.hasNetworkChanged(networkHealthyModel), true);

      // Assert
      TestUtils.printInfo('Should return "false" as value of hasErrors');
      expect(actualPageReloadController.hasErrors, false);

      // ************************************************************************************************

      // Act
      actualPageReloadController.handleReloadCall(networkHealthyModel);

      // Assert
      TestUtils.printInfo('Should return "1" as value of activeReloadId, after first reload called');
      expect(actualPageReloadController.activeReloadId, 1);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(0), false);

      // Assert
      TestUtils.printInfo('Should return "true" if provided reloadId is active');
      expect(actualPageReloadController.canReloadComplete(1), true);

      // Assert
      TestUtils.printInfo('Should return "true" if used network is other than provided network');
      expect(actualPageReloadController.hasNetworkChanged(networkUnhealthyModel), true);

      // Assert
      TestUtils.printInfo('Should return "false" if used network is equal provided network');
      expect(actualPageReloadController.hasNetworkChanged(networkHealthyModel), false);

      // Assert
      TestUtils.printInfo('Should return "false" if hasErrors is not set');
      expect(actualPageReloadController.hasErrors, false);

      // ************************************************************************************************

      // Act
      actualPageReloadController.handleReloadCall(networkUnhealthyModel);

      // Assert
      TestUtils.printInfo('Should return "2" as value of activeReloadId, after second reload called');
      expect(actualPageReloadController.activeReloadId, 2);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(0), false);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(1), false);

      // Assert
      TestUtils.printInfo('Should return "true" if provided reloadId is active');
      expect(actualPageReloadController.canReloadComplete(2), true);

      // Assert
      TestUtils.printInfo('Should return "false" if used network is equal provided network');
      expect(actualPageReloadController.hasNetworkChanged(networkUnhealthyModel), false);

      // Assert
      TestUtils.printInfo('Should return "true" if used network is other than provided network');
      expect(actualPageReloadController.hasNetworkChanged(networkHealthyModel), true);

      // Assert
      TestUtils.printInfo('Should set hasErrors to "false" after handleReloadCall');
      expect(actualPageReloadController.hasErrors, false);
    });
  });
}
