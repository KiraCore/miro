import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_condition_type.dart';
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
      interxVersion: 'v0.4.20-rc2',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
    ),
  );

  group('Tests of PageReloadController process for PageReloadConditionType.differentNetwork', () {
    test('Should return values assigned to specified actions', () {
      // Arrange
      PageReloadController actualPageReloadController = PageReloadController(pageReloadConditionType: PageReloadConditionType.changedNetwork);

      // Assert
      TestUtils.printInfo('Should return "0" as initial value');
      expect(actualPageReloadController.activeReloadId, 0);

      // Assert
      TestUtils.printInfo('Should return "true" if reloadId is active');
      expect(actualPageReloadController.canReloadComplete(0), true);

      // Assert
      TestUtils.printInfo('Should return "true" if usedReloadId is empty');
      expect(actualPageReloadController.canReloadStart(networkHealthyModel), true);

      // Act
      actualPageReloadController.handleReloadCall(networkHealthyModel);

      // Assert
      TestUtils.printInfo('Should return "1" after first reload called');
      expect(actualPageReloadController.activeReloadId, 1);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(0), false);

      // Assert
      TestUtils.printInfo('Should return "true" if provided reloadId is active');
      expect(actualPageReloadController.canReloadComplete(1), true);

      // Assert
      TestUtils.printInfo('Should return "false" when provided NetworkStatusModel is equal used NetworkStatusModel (network refreshed)');
      expect(actualPageReloadController.canReloadStart(networkHealthyModel), false);

      // Act
      actualPageReloadController.hasErrors = true;

      // Assert
      TestUtils.printInfo('Should return "true" when provided NetworkStatusModel is equal used NetworkStatusModel but page has errors');
      expect(actualPageReloadController.canReloadStart(networkHealthyModel), true);

      // Assert
      TestUtils.printInfo('Should return "true" when provided NetworkStatusModel is different than used NetworkStatusModel url (network changed)');
      expect(actualPageReloadController.canReloadStart(networkUnhealthyModel), true);

      // Act
      actualPageReloadController.handleReloadCall(networkUnhealthyModel);

      // Assert
      TestUtils.printInfo('Should return "2" after second reload called');
      expect(actualPageReloadController.activeReloadId, 2);
    });
  });
}
